import 'package:flutter/material.dart';

import '../types.dart';

class SeatCellWidget extends StatelessWidget {
  final int x;
  final int y;
  final bool isAfternoon;
  final Booking? booking;
  final bool isActive;
  final void Function(Seat seat) onClick;

  const SeatCellWidget(this.x, this.y, this.isAfternoon, this.booking,
      this.isActive, this.onClick,
      {super.key});

  SeatCellWidget updateWithValues(
    Booking? booking,
    bool isActive,
  ) =>
      SeatCellWidget(x, y, isAfternoon, booking, isActive, onClick);

  @override
  Widget build(BuildContext context) {
    final seat = Seat(y, x);

    getColor() {
      if (isActive) return Colors.lightBlue.shade50;
      if (booking == null) return Colors.green;

      var amountOfPaidSeats = booking!.paidAmount /
          booking!.getPrice(isAfternoon) *
          booking!.seats.length;

      if (booking!.getSeatsSorted().indexOf(seat) < amountOfPaidSeats) {
        return Colors.red;
      } else {
        return Colors.yellow;
      }
    }

    String getText() => booking?.lastName ?? seat.toString();

    return Expanded(
        flex: 2,
        child: GestureDetector(
            onTapDown: (_) {
              onClick(seat);
            },
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(), color: getColor()),
              child: Text(
                getText(),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            )));
  }
}
