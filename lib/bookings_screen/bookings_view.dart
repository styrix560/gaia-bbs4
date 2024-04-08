import 'package:bbs4/bookings_screen/edit_booking.dart';
import 'package:bbs4/bookings_screen/seat_cell.dart';
import 'package:bbs4/types.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:uuid/uuid.dart';

import '../grid_definition.dart';

class BookingsView extends HookWidget {
  final bool isAfternoon;

  final Uuid uuid = const Uuid();

  // data-variables
  List<Booking> bookings = [];
  Booking? activeBooking; // the booking that is currently being edited

  // UI-variables
  Map<String, SeatCellWidget> seatCells;

  void onClick(Seat seat) {
    if (activeBooking == null) {
      initActiveBooking(seat);
      return;
    }
    if (activeBooking!.seats.contains(seat)) {
      activeBooking!.seats.remove(seat);
      seatCells[seat.toString()]!.updateState(null, false);
    } else {
      activeBooking!.seats.add(seat);
      seatCells[seat.toString()]!.updateState(activeBooking, true);
    }
  }

  BookingsView(this.isAfternoon, {super.key})
      : bookings = [
          Booking(isAfternoon, "id", "Max", "Mustermann", "7A",
              [Seat(0, 9), Seat(0, 10), Seat(0, 11)], 15, PriceType.Normal),
          Booking(isAfternoon, "id2", "V", "IP", "important class",
              [Seat(0, 0), Seat(0, 1)], 30, PriceType.Normal)
        ],
        seatCells = {} {
    var yAll = 0;
    seatCells = {
      for (final rect in bookingsDefinition)
        for (var y = 0; y < rect.height; y++, yAll++)
          for (var x = 0; x < rect.width; x++)
            Seat(yAll, x).toString():
                SeatCellWidget(x, yAll, isAfternoon, onClick, false),
    };

    for (var booking in bookings) {
      for (var seat in booking.seats) {
        seatCells[seat.toString()]!.booking = booking;
      }
    }
  }

  List<Widget> addPadding(int rectWidth) {
    return [
      if ((maxRowLength + rectWidth) % 2 != 0) const Spacer(),
      for (var x = 0; x < (maxRowLength - rectWidth) / 2; x++)
        const Spacer(flex: 2),
    ];
  }

  initActiveBooking([Seat? seat]) {
    activeBooking = Booking(false, uuid.v4().toString(), "", "", "",
        [if (seat != null) seat], 0, PriceType.Normal);
  }

  @override
  Widget build(BuildContext context) {
    var yAll = 0;

    return Column(
      children: [
        for (final rect in bookingsDefinition)
          for (var y = 0; y < rect.height; y++, yAll++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...addPadding(rect.width),
                for (var x = 0; x < rect.width; x++)
                  seatCells[Seat(yAll, x).toString()]!,
                ...addPadding(rect.width),
              ],
            ),
        EditBookingWidget(activeBooking)
      ],
    );
  }
}
