import "package:flutter/material.dart";

import "../types.dart";

class SeatCellWidget extends StatelessWidget {
  const SeatCellWidget(
    this.x,
    this.y,
    this.booking, {
    required this.isAfternoon,
    required this.isActive,
    super.key,
  });

  final int x;
  final int y;
  final bool isAfternoon;
  final Booking? booking;
  final bool isActive;

  SeatCellWidget updateWithValues(
    Booking? booking, {
    required bool isActive,
  }) =>
      SeatCellWidget(
        x,
        y,
        booking,
        isActive: isActive,
        isAfternoon: isAfternoon,
      );

  @override
  Widget build(BuildContext context) {
    final seat = Seat(y, x);

    Color getColor() {
      // TODO(styrix): also show paid seats for active bookings
      if (booking == null) return Colors.green;

      // TODO: isAfternoon
      final pricePerSeat =
          booking!.priceType.calculatePrice(isAfternoon: false);
      final amountOfPaidSeats =
          pricePerSeat == 0 ? 1000 : booking!.pricePaid ~/ pricePerSeat;

      if (booking!.getSeatsSorted().indexOf(seat) < amountOfPaidSeats) {
        return isActive ? Colors.blue.shade800 : Colors.red;
      } else {
        return isActive ? Colors.blue.shade200 : Colors.yellow;
      }
    }

    String getText() => booking?.lastName ?? seat.toString();

    return Expanded(
      flex: 2,
      child: GestureDetector(
        onTapDown: (_) {
          onClick(seat);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: const Border.fromBorderSide(BorderSide()),
            color: getColor(),
          ),
          child: Text(
            getText(),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  void onClick(Seat seat) {
    final globalData = GlobalData();
    final clickedBookings = globalData.findClickedBookings(seat);
    assert(clickedBookings.length < 2);

    if (clickedBookings.length == 1) {
      final newBooking = clickedBookings.first;
      globalData.changeActiveBooking(newBooking);
      return;
    }

    if (!globalData.isBookingActive()) {
      globalData.initActiveBooking(seat);
      return;
    }

    globalData.updateActiveBookingSeats(seat);
  }
}
