import "dart:math";

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:supernova/supernova.dart" hide IterableSorted;

import "../types/booking_time.dart";
import "../types/global_data.dart";
import "../types/seat.dart";
import "../utils.dart";
import "custom_menu_button.dart";

class OverviewWidget extends HookWidget {
  const OverviewWidget(this.parentTabController, {super.key});

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
    var formattedSeats = "";
    while (true) {
      final nextSeats = seatList.take(5);
      seatList.removeRange(0, min(5, seatList.length));
      formattedSeats += nextSeats.join(" / ");
      if (seatList.isEmpty) break;
      formattedSeats += "\n";
    }
    return formattedSeats;
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

    return Column(
      children: [
        Row(
          children: [
            CustomMenuButton(
              globalData.bookingTime,
              BookingTime.values,
              (bookingTime) => bookingTime.germanName,
              (newBookingTime) {
                if (newBookingTime == null) return;
                globalData.bookingTime = newBookingTime;
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
            for (final booking in globalData.bookings.value
                .where((element) => element.matches(searchQuery.text)))
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
    );
  }
}
