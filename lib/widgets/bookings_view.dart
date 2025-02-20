import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../types/booking_time.dart";
import "../types/global_data.dart";
import "../types/seat.dart";
import "../types/seat_layout.dart";
import "../utils.dart";
import "custom_menu_button.dart";
import "edit_booking.dart";
import "seat_cell.dart";

class BookingsView extends HookWidget {
  const BookingsView({super.key});

  Map<Seat, SeatCellWidget> initSeatCells() {
    final seatCells = <Seat, SeatCellWidget>{};

    for (final entry in seatLayout.entries) {
      for (final (y, width) in entry.value.indexed) {
        for (var x = 0; x < width; x++) {
          final seat = Seat(y, x, entry.key);
          seatCells[seat] = SeatCellWidget(seat);
        }
      }
    }

    return seatCells;
  }

  @override
  Widget build(BuildContext context) {
    final globalData = GlobalData();
    final bookingTime = GlobalData.currentBookingTime.value;
    final seatCells = useMemoized(initSeatCells, [
      bookingTime,
    ]);
    useListenableSelector(
      globalData.activeBooking,
      () => globalData.isBookingActive,
    );
    useListenable(GlobalData.currentBookingTime);
    useListenable(globalData.isTransactionInProgress);

    final transactionsDisabled =
        globalData.isBookingActive || globalData.isTransactionInProgress.value;

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
                GlobalData.currentBookingTime.value = newBookingTime;
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
        for (final entry in seatLayout.entries)
          Column(
            children: [
              Text(entry.key),
              for (final (y, width) in entry.value.indexed)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (width < maxRowLength)
                      Spacer(flex: maxRowLength - width),
                    for (var x = 0; x < width; x++)
                      seatCells[Seat(y, x, entry.key)]!,
                    if (width < maxRowLength)
                      Spacer(flex: maxRowLength - width),
                  ],
                ),
            ],
          ),
        const EditBookingWidget(),
      ],
    );
  }
}
