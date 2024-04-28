import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../types/booking.dart";
import "../types/booking_time.dart";
import "../types/global_data.dart";
import "../types/price_type.dart";
import "../types/seat.dart";
import "../utils.dart";

class SeatCellWidget extends HookWidget {
  const SeatCellWidget(
    this.x,
    this.y,
    this.bookingTime, {
    super.key,
  });

  final int x;
  final int y;
  final BookingTime bookingTime;

  @override
  Widget build(BuildContext context) {
    final seat = Seat(y, x);
    final globalData = GlobalData(bookingTime);
    final activeBooking = globalData.activeBooking;
    final rebuild = useRebuild();
    final prevBooking = usePrevious(globalData.activeBooking);

    bool shouldRebuild() {
      // TODO(styrix): make this more efficient
      return true;
    }

    useEffect(() {
      void callback() {
        if (shouldRebuild()) {
          rebuild();
        }
      }

      globalData.addListener(callback);
      return () => globalData.removeListener(callback);
    });

    Color getColor() {
      Color getColorForBooking(
          Booking booking, Color colorIfPaid, Color colorIfNotPaid) {
        final pricePerSeat = booking.priceType.calculatePrice(bookingTime);
        final amountOfPaidSeats =
            pricePerSeat == 0 ? 1000 : booking.pricePaid ~/ pricePerSeat;

        return booking.getSeatsSorted().indexOf(seat) < amountOfPaidSeats
            ? colorIfPaid
            : colorIfNotPaid;
      }

      if (globalData.activeBooking?.seats.contains(seat) ?? false) {
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
      if (globalData.activeBooking?.seats.contains(seat) ?? false) {
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
    final globalData = GlobalData(bookingTime);
    final clickedBookings = globalData.getBookingsContainingSeat(seat);
    // TODO(styrix): handle more than one booking per seat
    assert(clickedBookings.length < 2);

    if (clickedBookings.length == 1) {
      final newBooking = clickedBookings.first;
      globalData.changeActiveBooking(newBooking);
      return;
    }

    if (!globalData.isBookingActive) {
      globalData.initActiveBooking(seat);
      return;
    }

    final newSeats = globalData.activeBooking!.seats;
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
