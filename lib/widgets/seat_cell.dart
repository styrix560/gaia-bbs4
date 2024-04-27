import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../types.dart";
import "../utils.dart";

class SeatCellWidget extends HookWidget {
  const SeatCellWidget(
    this.x,
    this.y, {
    required this.isAfternoon,
    super.key,
  });

  final int x;
  final int y;
  final bool isAfternoon;

  @override
  Widget build(BuildContext context) {
    final seat = Seat(y, x);
    final globalData = GlobalData();
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
      if (!globalData.isBookingActive ||
          !globalData.activeBooking!.seats.contains(seat)) return Colors.green;

      // TODO: isAfternoon
      final pricePerSeat =
          activeBooking!.priceType.calculatePrice(isAfternoon: false);
      final amountOfPaidSeats =
          pricePerSeat == 0 ? 1000 : activeBooking.pricePaid ~/ pricePerSeat;

      if (activeBooking.getSeatsSorted().indexOf(seat) < amountOfPaidSeats) {
        return globalData.isBookingActive ? Colors.blue.shade800 : Colors.red;
      } else {
        return globalData.isBookingActive
            ? Colors.blue.shade200
            : Colors.yellow;
      }
    }

    String getText() {
      if (!globalData.isBookingActive ||
          !globalData.activeBooking!.seats.contains(seat)) {
        return seat.toString();
      }
      return activeBooking!.lastName;
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
    final clickedBookings = globalData.findClickedBookings(seat);
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
