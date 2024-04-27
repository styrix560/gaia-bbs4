import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../types/global_data.dart";
import "../types/grid_definition.dart";
import "../types/seat.dart";
import "../utils.dart";
import "edit_booking.dart";
import "seat_cell.dart";

// TODO(styrix): add afternoon as parameter
class BookingsView extends HookWidget {
  const BookingsView({super.key});

  Map<Seat, SeatCellWidget> initSeatCells() {
    final seatCells = <Seat, SeatCellWidget>{};

    for (final (y, width) in rowWidths.indexed) {
      for (var x = 0; x < width; x++) {
        final seat = Seat(y, x);
        seatCells[seat] = SeatCellWidget(x, y, isAfternoon: false);
      }
    }

    return seatCells;
  }

  @override
  Widget build(BuildContext context) {
    final seatCells = useRef(initSeatCells());
    final globalData = GlobalData();
    useListenableSelector(globalData, () => globalData.isBookingActive);

    final maxRowLength = rowWidths.max;

    // TODO(styrix): use "Rang" instead of "R" for ranks 21 or higher
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
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
        EditBookingWidget(),
      ],
    );
  }
}
