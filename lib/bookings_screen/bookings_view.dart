import 'package:bbs4/bookings_screen/edit_booking.dart';
import 'package:bbs4/bookings_screen/seat_cell.dart';
import 'package:bbs4/types.dart';
import 'package:bbs4/utils.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../grid_definition.dart';

class BookingsView extends StatefulWidget {
  final bool isAfternoon;
  final Uuid uuid = const Uuid();

  const BookingsView({super.key, required this.isAfternoon});

  @override
  State<StatefulWidget> createState() {
    return BookingViewState();
  }
}

class BookingViewState extends State<BookingsView> {
  // data-variables
  List<Booking> bookings = [];
  Booking? activeBooking; // the booking that is currently being edited

  // UI-variables
  Map<Seat, SeatCellWidget> seatCells;
  late EditBookingWidget editBookingWidget;

  initActiveBooking([Seat? seat]) {
    setState(() {
      activeBooking = Booking(widget.uuid.v4().toString(), "", "", "",
          {if (seat != null) seat}, 0, PriceType.normal);
    });
  }

  void onClick(Seat seat) {
    // if a different booking is pressed, make the new one active
    List<Booking> clickedBookings =
        bookings.where((element) => element.seats.contains(seat)).toList();
    assert(clickedBookings.length < 2);

    if (clickedBookings.length == 1) {
      if (activeBooking != null) {
        bookings.add(activeBooking!);

        activeBooking!.updateSeats(seatCells, false);
      }

      var newBooking = clickedBookings.first;
      bookings.remove(newBooking);
      activeBooking = newBooking;

      newBooking.updateSeats(seatCells, true);

      editBookingWidget.initialBooking.value = newBooking;

      // force rebuild
      setState(() {});
      return;
    }

    if (activeBooking == null) {
      initActiveBooking(seat);
      setState(() {
        seatCells[seat] = seatCells[seat]!.updateWithValues(
          activeBooking,
          true,
        );
        editBookingWidget.initialBooking.value = activeBooking;
      });
      return;
    }
    if (activeBooking!.seats.contains(seat)) {
      setState(() {
        activeBooking!.seats.remove(seat);
        if (activeBooking!.seats.isEmpty) {
          activeBooking = null;
          editBookingWidget.initialBooking.value = null;
        }
        seatCells[seat] = seatCells[seat]!.updateWithValues(null, false);
      });
    } else {
      setState(() {
        activeBooking!.seats.add(seat);
        seatCells[seat] =
            seatCells[seat]!.updateWithValues(activeBooking, true);
      });
    }
  }

  void onInput(Booking newBooking) {
    setState(() {
      activeBooking = newBooking;
      newBooking.updateSeats(seatCells, true);
    });
  }

  BookingViewState()
      : bookings = [
          Booking(
              "id",
              "Max",
              "Mustermann",
              "7A",
              {const Seat(0, 9), const Seat(0, 10), const Seat(0, 11)},
              15,
              PriceType.normal),
          Booking("id2", "VERY", "VIP", "important class",
              {const Seat(0, 0), const Seat(0, 1)}, 30, PriceType.normal)
        ],
        seatCells = {};

  @override
  Widget build(BuildContext context) {
    Widget addPadding(int rectWidth) {
      return Expanded(
          flex: maxRowLength - rectWidth, child: SizedBox(height: 10));
    }

    var yAll = 0;

    return Column(
      children: [
        Row(
          children: [
            Spacer(),
            FilledButton(
                onPressed: activeBooking == null
                    ? null
                    : () {
                        if (activeBooking == null) return;
                        bookings.add(activeBooking!);

                        activeBooking!.updateSeats(seatCells, false);
                        activeBooking = null;
                        editBookingWidget.initialBooking.value = null;
                        setState(() {});
                      },
                child: Text(
                  "Buchung speichern",
                ))
          ],
        ),
        context.space(0, 16),
        for (final rect in bookingsDefinition)
          for (var y = 0; y < rect.height; y++, yAll++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                addPadding(rect.width),
                for (var x = 0; x < rect.width; x++) seatCells[Seat(yAll, x)]!,
                addPadding(rect.width),
              ],
            ),
        editBookingWidget
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    var yAll = 0;
    seatCells = {
      for (final rect in bookingsDefinition)
        for (var y = 0; y < rect.height; y++, yAll++)
          for (var x = 0; x < rect.width; x++)
            Seat(yAll, x): SeatCellWidget(
                x, yAll, widget.isAfternoon, null, false, onClick),
    };

    for (var booking in bookings) {
      booking.updateSeats(seatCells, false);
    }

    editBookingWidget = EditBookingWidget(activeBooking, onInput);

    setState(() {});
  }
}
