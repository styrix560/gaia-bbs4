import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../types.dart';

class SeatCellWidget extends HookWidget {
  final int x;
  final int y;
  final bool isAfternoon;
  final Seat seat;
  Booking? booking;
  bool isActive;

  void Function(Seat seat) onClick;

  SeatCellWidget(this.x, this.y, this.isAfternoon, this.onClick, this.isActive)
      : seat = Seat(y, x);

  void updateState(Booking? booking, bool isActive) {
    if (this.booking == booking && this.isActive == isActive) return;
    this.booking = booking;
    this.isActive = isActive;
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild seat cell ${seat.toString()}');
    var rebuildCounter = useState(0);
    rebuild() => rebuildCounter.value++;

    getColor() {
      if (isActive) return Colors.lightBlue.shade50;
      if (booking == null) return Colors.green;

      var amountOfPaidSeats =
          booking!.paidAmount / booking!.price * booking!.seats.length;

      if (booking!.seats.indexOf(Seat(y, x)) < amountOfPaidSeats) {
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
          rebuild();
        },
        child: Container(
          decoration: BoxDecoration(border: Border.all(), color: getColor()),
          child: Text(
            getText(),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
