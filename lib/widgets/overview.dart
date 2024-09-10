import "dart:math";

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;
import "package:printing/printing.dart";
import "package:supernova/supernova.dart" hide IterableSorted;

import "../types/booking.dart";
import "../types/booking_time.dart";
import "../types/global_data.dart";
import "../types/seat.dart";
import "../utils.dart";
import "custom_menu_button.dart";

class OverviewWidget extends HookWidget {
  const OverviewWidget(
    this.parentTabController, {
    super.key,
  });

  static String _lastQueryValue = "";

  final TabController parentTabController;

  String formatSeats(Set<Seat> seats) {
    if (seats.isEmpty) return "";
    final seatList = seats.toList().sorted(
      (a, b) {
        if (a.row == b.row) {
          return a.seat.compareTo(b.seat);
        }
        return a.row.compareTo(b.row);
      },
    );
    final formattedSeats = StringBuffer();
    while (true) {
      final nextSeats = seatList.take(5);
      seatList.removeRange(0, min(5, seatList.length));
      formattedSeats.write(nextSeats.join(" / "));
      if (seatList.isEmpty) break;
      formattedSeats.write("\n");
    }
    return formattedSeats.toString();
  }

  @override
  Widget build(BuildContext context) {
    final globalData = GlobalData();
    useListenable(globalData.isTransactionInProgress);
    useListenable(GlobalData.currentBookingTime);

    final searchQuery = useTextEditingController(text: _lastQueryValue);
    useListenable(searchQuery);
    useEffect(
      () {
        _lastQueryValue = searchQuery.text;
        return () {};
      },
      [searchQuery.text],
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Spacer(),
                OutlinedButton(
                    onPressed: globalData.isTransactionInProgress.value
                        ? null
                        : () => printOverview(searchQuery.text),
                    child: Text("Drucken")),
              ],
            ),
          ),
          Row(
            children: [
              CustomMenuButton(
                GlobalData.currentBookingTime.value,
                BookingTime.values,
                (bookingTime) => bookingTime.germanName,
                (newBookingTime) {
                  if (newBookingTime == null) return;
                  GlobalData.currentBookingTime.value = newBookingTime;
                },
                disabled: globalData.isTransactionInProgress.value,
              ),
              const Spacer(),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: searchQuery,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          space(height: 16),
          Table(
            border: const TableBorder(
              horizontalInside: BorderSide(),
              top: BorderSide(),
              bottom: BorderSide(),
              left: BorderSide(),
              right: BorderSide(),
            ),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              for (final booking in getFilteredBookings(searchQuery.text))
                TableRow(
                  children: [
                    Text(booking.lastName),
                    Text(booking.firstName),
                    Text(booking.className),
                    Text(
                      booking.seats.join("\n"),
                    ),
                    Text("${booking.pricePaid}€"),
                    Text(booking.priceType.germanName),
                    Text(booking.comments),
                    OutlinedButton(
                      onPressed: () {
                        globalData.changeActiveBooking(booking);
                        parentTabController.animateTo(0);
                      },
                      child: const Text("Buchung\naktivieren"),
                    ),
                  ]
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8),
                            child: e,
                          ))
                      .toList(),
                ),
            ],
          ),
        ],
      ),
    );
  }

  List<List<Booking>> getPagedBookings(List<Booking> bookings) {
    if (bookings.isEmpty) return [];
    final List<List<Booking>> paged = [[]];
    const maxSeatsPerPage = 50;
    int seatsPerPage = 0;
    for (var bookingIndex = 0; bookingIndex < bookings.length; bookingIndex++) {
      final booking = bookings[bookingIndex];
      final bookingLength = booking.seats.length +
          booking.getSeatsByGroup().length +
          1; // add 1 for padding and 1 for each groupName
      seatsPerPage += bookingLength;
      if (seatsPerPage <= maxSeatsPerPage) {
        paged.last.add(booking);
        continue;
      }
      final partition = maxSeatsPerPage - (seatsPerPage - booking.seats.length);
      if (partition <= 0) {
        seatsPerPage = 0;
        paged.add([]);
        bookingIndex--;
        continue;
      }
      bookings.removeAt(bookingIndex);
      final seats = booking.getSeatsSorted().getRange(0, partition).toSet();
      final restSeats = booking
          .getSeatsSorted()
          .getRange(partition, booking.seats.length)
          .toSet();
      final bookingCopy = booking.copy(seats: seats);
      paged.last.add(bookingCopy);
      paged.add([]);
      seatsPerPage = 0;
      final newBooking = booking.copy(seats: restSeats);
      bookings.insert(bookingIndex, newBooking);
      bookingIndex--;
    }
    Logger().log(LogLevel.debug, "paged", paged);
    return paged;
  }

  Future<void> printOverview(String query) async {
    if (GlobalData().isTransactionInProgress.value) {
      snackbar("Bitte warten, bis die Transaktion abgeschlossen ist");
      return;
    }
    Logger().log(LogLevel.info, "Filtering and Paging of Bookings");
    final bookings = getFilteredBookings(query);
    for (var i = 0; i < 10; i++) {
      bookings.add(bookings.last);
    }
    final seats = Set.of(bookings.last.seats);
    for (var i = 0; i < 100; i++) {
      seats.add(Seat(5, i + 5, "Parkett"));
    }
    bookings.add(bookings.last.copy(seats: seats));
    Logger().log(LogLevel.info, "Generating pdf");
    final pdf = await _generatePdf(PdfPageFormat.a4, bookings);
    Logger().log(LogLevel.info, "Beginning Printing");
    await Printing.layoutPdf(onLayout: (format) => pdf.save());
    Logger().log(LogLevel.info, "Finished printing");
  }

  List<Booking> getFilteredBookings(String query) => GlobalData()
      .bookings
      .value
      .where((element) => element.matches(query))
      .toList();

  Future<pw.Document> _generatePdf(
    PdfPageFormat format,
    List<Booking> bookings,
  ) async {
    final pdf = pw.Document();
    Logger().log(LogLevel.info, "Getting Google Fonts");
    final regular = await PdfGoogleFonts.robotoSlabRegular();
    final medium = await PdfGoogleFonts.robotoSlabMedium();
    Logger().log(LogLevel.info, "Got Google Fonts");
    final regularStyle = pw.TextStyle(font: regular, fontSize: 11);
    final mediumStyle = pw.TextStyle(font: medium, fontSize: 11);
    for (final bookings in getPagedBookings(bookings)) {
      pdf.addPage(
        pw.Page(
          margin: const pw.EdgeInsets.all(16),
          pageFormat: format,
          build: (context) => pw.Column(children: [
            pw.Table(
              border: pw.TableBorder.all(),
              defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
              defaultColumnWidth: const pw.IntrinsicColumnWidth(flex: 1),
              children: [
                pw.TableRow(
                  children: [
                    "Vorname",
                    "Nachname",
                    "Klasse",
                    "Preisart",
                    "Kommentare",
                    "Bezahlt",
                    "Sitze"
                  ]
                      .map((string) => pw.Padding(
                            padding: pw.EdgeInsets.all(4),
                            child: pw.Center(
                              child: pw.Text(string, style: mediumStyle),
                            ),
                          ))
                      .toList(),
                ),
                for (final booking in bookings)
                  pw.TableRow(
                    children: ([
                          booking.firstName,
                          booking.lastName,
                          booking.className,
                          booking.priceType.germanName,
                          booking.comments,
                          "${booking.pricePaid}€ / ${booking.getPrice(bookingTime: GlobalData.currentBookingTime.value)}€",
                        ]
                            .map((string) =>
                                pw.Text(string, style: regularStyle))
                            .map((child) => pw.Center(child: child))
                            .map((child) => pw.Padding(
                                  padding: const pw.EdgeInsets.all(2),
                                  child: child,
                                ))
                            .toList()) +
                        [
                          pw.Padding(
                            padding: pw.EdgeInsets.all(2),
                            child: pw.Column(children: [
                              for (final entry
                                  in booking.getSeatsByGroup().entries)
                                pw.Column(children: [
                                  pw.Text(entry.key, style: mediumStyle),
                                  for (final seat in entry.value)
                                    pw.Text(seat.toString(),
                                        style: regularStyle),
                                ]),
                            ]),
                          ),
                        ],
                  ),
              ],
            ),
          ]),
        ),
      );
    }

    return pdf;
  }
}
