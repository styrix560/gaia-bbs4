import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../main.dart";
import "../types/booking.dart";

// When the bookings are merged from the database it is possible, that some
// seats are booked more than once. This dialog allows the user to choose, which
// one of the multiple Bookings attached to a seat they want to edit
class SeatDisambiguationWidget extends HookWidget {
  final List<Booking> bookings;

  const SeatDisambiguationWidget(this.bookings);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Zu diesem Sitz gehören mehr als eine Buchung."),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text("Bitte die zu bearbeitende Buchung auswählen:"),
            for (final booking in bookings)
              Row(
                children: [
                  Text("${booking.lastName}, ${booking.firstName}"),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        navigatorKey.currentState!.pop(booking);
                      },
                      icon: Icon(Icons.edit)),
                ],
              )
          ],
        ),
      ),
    );
  }
}
