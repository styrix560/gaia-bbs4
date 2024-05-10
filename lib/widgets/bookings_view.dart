import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:supernova/supernova.dart";

import "../types/booking_time.dart";
import "../types/global_data.dart";
import "../types/grid_definition.dart";
import "../types/seat.dart";
import "../utils.dart";
import "custom_menu_button.dart";
import "edit_booking.dart";
import "seat_cell.dart";

class BookingsView extends HookWidget {
  const BookingsView({super.key});

  Map<Seat, SeatCellWidget> initSeatCells(BookingTime bookingTime) {
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
    final globalData = GlobalData();
    final bookingTime = globalData.bookingTime;
    final seatCells = useMemoized(() => initSeatCells(bookingTime), [
      bookingTime,
    ]);
    useListenableSelector(
      globalData.activeBooking,
      () => globalData.isBookingActive,
    );
    useListenable(GlobalData.currentBookingTime);
    useListenable(globalData.isTransactionInProgress);

    final maxRowLength = rowWidths.max;

    final transactionsDisabled =
        globalData.isBookingActive || globalData.isTransactionInProgress.value;

    // TODO(styrix): use "Rang" instead of "R" for ranks 21 or higher
    // TODO(styrix): get feedback for the EditBookingsWidget
    return Column(
      children: [
        Row(
          children: [
            CustomMenuButton(
              bookingTime,
              BookingTime.values,
              (p0) => p0.germanName,
              (newBookingTime) {
                if (newBookingTime == null) return;
                globalData.bookingTime = newBookingTime;
              },
              disabled: transactionsDisabled,
            ),
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
              for (var x = 0; x < width; x++) seatCells[Seat(y, x)]!,
              if (width < maxRowLength) Spacer(flex: maxRowLength - width),
            ],
          ),
        EditBookingWidget(),
      ],
    );
  }
}
