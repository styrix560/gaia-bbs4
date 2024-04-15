import "package:flutter/material.dart";

import "../event_notifier.dart";
import "../grid_definition.dart";
import "../types.dart";
import "../utils.dart";
import "edit_booking.dart";
import "seat_cell.dart";

class BookingsView extends StatefulWidget {
  const BookingsView({super.key, required this.isAfternoon});

  final bool isAfternoon;

  @override
  State<StatefulWidget> createState() {
    return BookingViewState();
  }
}

class BookingViewState extends State<BookingsView> {
  BookingViewState() : seatCells = {};

  // UI-variables
  Map<Seat, SeatCellWidget> seatCells;
  late EditBookingWidget editBookingWidget;

  @override
  Widget build(BuildContext context) {
    var yAll = 0;

    // TODO(styrix): use "Rang" instead of "R" for ranks 21 or higher
    final globalData = GlobalData();
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            FilledButton(
              onPressed: !globalData.isBookingActive()
                  ? null
                  : globalData.deactivateBooking,
              child: const Text(
                "Buchung speichern",
              ),
            ),
          ],
        ),
        space(0, 16),
        for (final rect in bookingsDefinition)
          for (var y = 0; y < rect.height; y++, yAll++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (rect.width < maxRowLength)
                  Spacer(flex: maxRowLength - rect.width),
                for (var x = 0; x < rect.width; x++) seatCells[Seat(yAll, x)]!,
                if (rect.width < maxRowLength)
                  Spacer(flex: maxRowLength - rect.width),
              ],
            ),
        editBookingWidget,
      ],
    );
  }

  void initCallbacks() {
    // TODO(styrix): dispose these callbacks
    final globalData = GlobalData();
    globalData.activeBookingAddListener<ActiveBookingDeactivatedEventArgs>(
      (eventArgs) {
        setState(() {
          eventArgs.oldBooking.updateSeats(seatCells, isActive: false);
        });
      },
    );
    globalData
        .activeBookingAddListener<ActiveBookingActivatedEventArgs>((eventArgs) {
      setState(() {
        eventArgs.newBooking.updateSeats(seatCells, isActive: true);
      });
    });
    globalData
        .activeBookingAddListener<ActiveBookingDeletedEventArgs>((eventArgs) {
      setState(() {
        eventArgs.oldBooking.updateSeats(seatCells, resetBooking: true);
      });
    });
    globalData
        .activeBookingAddListener<ActiveBookingSeatAddedEventArgs>((eventArgs) {
      setState(() {
        // ignore: avoid-collection-methods-with-unrelated-types
        eventArgs.newSeat.update(
          seatCells,
          globalData.activeBooking,
          isActive: true,
        );
      });
    });
    globalData
        .activeBookingAddListener<ActiveBookingCreatedEventArgs>((eventArgs) {
      setState(() {
        eventArgs.activeBooking.updateSeats(seatCells, isActive: true);
      });
    });
    globalData.activeBookingAddListener<ActiveBookingSeatRemovedEventArgs>(
      (eventArgs) => setState(() {
        eventArgs.oldSeat.update(
          seatCells,
          null,
          isActive: false,
        );
      }),
    );
    globalData
        .activeBookingAddListener<ActiveBookingUpdatedEventArgs>((eventArgs) {
      setState(() {
        globalData.activeBooking!.updateSeats(seatCells, isActive: true);
      });
    });

    globalData.bookingsAddListener<BookingsUpdated>((eventArgs) {
      initSeatCells();
      for (final booking in eventArgs.newBookings) {
        booking.updateSeats(seatCells, isActive: false);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    initCallbacks();
    initSeatCells();

    final globalData = GlobalData();

    for (final booking in globalData.bookings) {
      booking.updateSeats(seatCells, isActive: false);
    }

    editBookingWidget = const EditBookingWidget();
  }

  void initSeatCells() {
    var yAll = 0;
    seatCells = {
      for (final rect in bookingsDefinition)
        for (var y = 0; y < rect.height; y++, yAll++)
          for (var x = 0; x < rect.width; x++)
            Seat(yAll, x): SeatCellWidget(
              x,
              yAll,
              null,
              isAfternoon: widget.isAfternoon,
              isActive: false,
            ),
    };
  }
}
