import "dart:math";

import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../types/booking_time.dart";
import "../types/global_data.dart";
import "../types/seat.dart";

class OverviewWidget extends HookWidget {
  final TabController parentTabController;

  OverviewWidget(this.parentTabController);

  final BookingTime bookingTime = BookingTime.afternoon;

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
    final globalData = GlobalData(bookingTime);
    useListenable(globalData.isTransactionInProgress);
    return Table(
      border: const TableBorder(
        horizontalInside: BorderSide(),
        top: BorderSide(),
        bottom: BorderSide(),
        left: BorderSide(),
        right: BorderSide(),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        for (final booking in globalData.bookings.value)
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
                  child: Text("Buchung\naktivieren")),
            ]
                .map((e) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: e,
                    ))
                .toList(),
          ),
      ],
    );
  }
}
