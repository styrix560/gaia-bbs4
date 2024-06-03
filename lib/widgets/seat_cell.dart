import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../types/booking.dart";
import "../types/global_data.dart";
import "../types/price_type.dart";
import "../types/seat.dart";
import "seat_disambiguation.dart";

class SeatCellWidget extends HookWidget {
  const SeatCellWidget(
    this.seat, {
    super.key,
  });

  final Seat seat;

  @override
  Widget build(BuildContext context) {
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
            .calculatePricePerSeat(GlobalData.currentBookingTime.value);
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
          onClick(context, seat);
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

  Future<void> onClick(BuildContext context, Seat seat) async {
    final globalData = GlobalData();
    final activeBooking = globalData.activeBooking.value;
    final clickedBookings = globalData.getBookingsContainingSeat(seat);
    if (clickedBookings.length > 1) {
      final selectedBooking = await showDialog<Booking>(
        context: context,
        builder: (context) => SeatDisambiguationWidget(clickedBookings),
      );
      globalData.changeActiveBooking(selectedBooking);
      return;
    }

    if (!globalData.isBookingActive) {
      if (clickedBookings.length == 1) {
        final newBooking = clickedBookings.first;
        globalData.changeActiveBooking(newBooking);
        return;
      }
      globalData.initializeActiveBooking(seat);
      return;
    }

    // make a copy to avoid changing the reference in activeBooking
    final newSeats = Set.of(activeBooking!.seats);
    if (newSeats.contains(seat)) {
      if (newSeats.length > 1) {
        newSeats.remove(seat);
      }
    } else {
      newSeats.add(seat);
    }
    globalData.updateActiveBooking(seats: newSeats);
  }
}
