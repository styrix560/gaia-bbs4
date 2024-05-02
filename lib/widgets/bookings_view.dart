import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:supernova/supernova.dart";

import "../types/booking_time.dart";
import "../types/global_data.dart";
import "../types/grid_definition.dart";
import "../types/seat.dart";
import "../utils.dart";
import "edit_booking.dart";
import "seat_cell.dart";

class BookingsView extends HookWidget {
  const BookingsView(this.bookingTime, {super.key});

  final BookingTime bookingTime;

  Map<Seat, SeatCellWidget> initSeatCells() {
    final seatCells = <Seat, SeatCellWidget>{};

    for (final (y, width) in rowWidths.indexed) {
      for (var x = 0; x < width; x++) {
        final seat = Seat(y, x);
        seatCells[seat] = SeatCellWidget(x, y, bookingTime);
      }
    }

    return seatCells;
  }

  @override
  Widget build(BuildContext context) {
    final seatCells = useRef(initSeatCells());
    final globalData = GlobalData(bookingTime);
    useListenableSelector(globalData, () => globalData.isBookingActive);
    useListenable(globalData.isTransactionInProgress);

    final maxRowLength = rowWidths.max;

    final transactionsDisabled =
        globalData.isBookingActive || globalData.isTransactionInProgress.value;

    // TODO(styrix): use "Rang" instead of "R" for ranks 21 or higher
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            FilledButton(
              onPressed: transactionsDisabled ? null : globalData.loadBookings,
              child: const Text("Buchungen zurücksetzen"),
            ),
            space(width: 16),
            FilledButton(
              onPressed: transactionsDisabled ? null : globalData.pushBookings,
              child: const Text("Datenbank aktualisieren"),
            ),
            space(width: 16),
            FilledButton(
              onPressed: !globalData.isBookingActive
                  ? null
                  : () => globalData.changeActiveBooking(null),
              child: const Text(
                "Buchung speichern",
              ),
            ),
          ],
        ),
        space(height: 16),
        for (final (y, width) in rowWidths.indexed)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (width < maxRowLength) Spacer(flex: maxRowLength - width),
              for (var x = 0; x < width; x++) seatCells.value[Seat(y, x)]!,
              if (width < maxRowLength) Spacer(flex: maxRowLength - width),
            ],
          ),
        EditBookingWidget(bookingTime),
      ],
    );
  }
}
