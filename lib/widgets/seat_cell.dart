import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../types/booking.dart";
import "../types/global_data.dart";
import "../types/price_type.dart";
import "../types/seat.dart";

class SeatCellWidget extends HookWidget {
  const SeatCellWidget(
    this.x,
    this.y, {
    super.key,
  });

  final int x;
  final int y;

  @override
  Widget build(BuildContext context) {
    final seat = Seat(y, x);
    final globalData = GlobalData();
    final activeBooking = globalData.activeBooking.value;
    // final rebuild = useRebuild();
    // final previousBooking = useRef<Booking?>(null);
    useListenable(globalData.activeBooking);
    useListenable(globalData.bookings);

    // bool shouldRebuild() {
    //   final prevBooking = previousBooking.value?.copy();
    //   previousBooking.value = activeBooking?.copy();
    //
    //   bool isActive(Booking? booking) => booking?.seats.contains(seat) ?? false;
    //   final isActiveNow = isActive(activeBooking);
    //   final wasActiveBefore = isActive(prevBooking);
    //   if (isActiveNow != wasActiveBefore) return true;
    //   if (!isActiveNow) return false;
    //
    //   return activeBooking!.seats.length != prevBooking!.seats.length ||
    //       activeBooking.lastName != prevBooking.lastName ||
    //       activeBooking.pricePaid != prevBooking.pricePaid ||
    //       activeBooking.priceType != prevBooking.priceType;
    // }

    Color getColor() {
      Color getColorForBooking(
          Booking booking, Color colorIfPaid, Color colorIfNotPaid) {
        final pricePerSeat = booking.priceType
            .calculatePrice(GlobalData.currentBookingTime.value);
        final amountOfPaidSeats =
            pricePerSeat == 0 ? 1000 : booking.pricePaid ~/ pricePerSeat;

        return booking.getSeatsSorted().indexOf(seat) < amountOfPaidSeats
            ? colorIfPaid
            : colorIfNotPaid;
      }

      if (activeBooking?.seats.contains(seat) ?? false) {
        return getColorForBooking(
          activeBooking!,
          Colors.blue.shade800,
          Colors.blue.shade200,
        );
      }

      final bookings = globalData.getBookingsContainingSeat(seat);
      if (bookings.length == 2) return Colors.purple;
      if (bookings.isEmpty) return Colors.green;

      final booking = bookings.first;
      return getColorForBooking(
        booking,
        Colors.red,
        Colors.yellow,
      );
    }

    String getText() {
      if (activeBooking?.seats.contains(seat) ?? false) {
        return activeBooking!.lastName;
      }
      final bookings = globalData.getBookingsContainingSeat(seat);
      return bookings.isEmpty
          ? seat.toString()
          : bookings.map((e) => e.lastName).join("/");
    }

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
    final activeBooking = globalData.activeBooking.value;
    final clickedBookings = globalData.getBookingsContainingSeat(seat);
    assert(clickedBookings.length < 2);

    if (clickedBookings.length == 1) {
      final newBooking = clickedBookings.first;
      globalData.changeActiveBooking(newBooking);
      return;
    }

    if (!globalData.isBookingActive) {
      globalData.initializeActiveBooking(seat);
      return;
    }

    // make a copy to avoid changing the reference in activeBooking
    final newSeats = Set.of(activeBooking!.seats);
    if (newSeats.contains(seat)) {
      newSeats.remove(seat);
    } else {
      newSeats.add(seat);
    }
    if (newSeats.isNotEmpty) {
      globalData.updateActiveBooking(seats: newSeats);
    } else {
      globalData.changeActiveBooking(null);
    }
  }
}
