import "package:flutter/material.dart";

import "../event_notifier.dart";
import "../types.dart";
import "../utils.dart";

class EditBookingWidget extends StatefulWidget {
  const EditBookingWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return EditBookingWidgetState();
  }
}

class EditBookingWidgetState extends State<EditBookingWidget> {
  late final TextEditingController lastName;
  late final TextEditingController firstName;
  late final TextEditingController className;
  int numberOfSeat = 0;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (!GlobalData().isBookingActive()) {
      return const Text("no active booking");
    }
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            children: [
              space(0, 32),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    decoration: const InputDecoration(label: Text("Vorname")),
                    controller: firstName,
                    onChanged: (value) =>
                        GlobalData().updateActiveBooking(firstName: value),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    decoration: const InputDecoration(label: Text("Nachname")),
                    controller: lastName,
                    onChanged: (value) =>
                        GlobalData().updateActiveBooking(lastName: value),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    decoration: const InputDecoration(label: Text("Klasse")),
                    controller: className,
                    onChanged: (value) =>
                        GlobalData().updateActiveBooking(className: value),
                  ),
                ),
              ),
            ],
          ),
          Text(numberOfSeat.toString()),
        ],
      ),
    );
  }

  void rebuild() => setState(() {});

  void updateStateFromBooking(Booking booking) {
    firstName.text = booking.firstName;
    lastName.text = booking.lastName;
    className.text = booking.className;
    numberOfSeat = booking.seats.length;
    rebuild();
  }

  @override
  void initState() {
    super.initState();
    lastName = TextEditingController();
    firstName = TextEditingController();
    className = TextEditingController();

    final globalData = GlobalData();

    // TODO(styrix): dispose these listeners
    globalData.activeBookingAddListener<ActiveBookingDeactivatedEventArgs>(
      (eventArgs) {
        rebuild();
      },
    );
    globalData
        .activeBookingAddListener<ActiveBookingActivatedEventArgs>((eventArgs) {
      final booking = eventArgs.newBooking;
      updateStateFromBooking(booking);
    });
    globalData
        .activeBookingAddListener<ActiveBookingDeletedEventArgs>((eventArgs) {
      rebuild();
    });
    globalData
        .activeBookingAddListener<ActiveBookingSeatAddedEventArgs>((eventArgs) {
      numberOfSeat++;
      rebuild();
    });
    globalData.activeBookingAddListener<ActiveBookingSeatRemovedEventArgs>(
      (eventArgs) {
        numberOfSeat--;
        rebuild();
      },
    );
    globalData
        .activeBookingAddListener<ActiveBookingUpdatedEventArgs>((eventArgs) {
      firstName.text = eventArgs.firstName ?? firstName.text;
      lastName.text = eventArgs.lastName ?? lastName.text;
      className.text = eventArgs.className ?? className.text;
    });

    globalData
        .activeBookingAddListener<ActiveBookingCreatedEventArgs>((eventArgs) {
      updateStateFromBooking(eventArgs.activeBooking);
    });
  }

  @override
  void dispose() {
    super.dispose();
    lastName.dispose();
    firstName.dispose();
    className.dispose();
  }
}
