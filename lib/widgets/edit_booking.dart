import "package:flutter/material.dart";

import "../event_notifier.dart";
import "../types.dart";
import "../utils.dart";
import "price_paid.dart";

class EditBookingWidget extends StatefulWidget {
  EditBookingWidget({super.key});

  // store this widget here, so that it does not gets disposed when its not
  // visible. this ensures that its listeners can pick up on events
  final pricePaidWidget = const PaidPriceWidget();

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
  PriceType priceType = PriceType.normal;

  final formKey = GlobalKey<FormState>();

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
    globalData.activeBookingListen<ActiveBookingDeactivatedEventArgs>(
      (eventArgs) {
        rebuild();
      },
    );
    globalData.activeBookingListen<ActiveBookingActivatedEventArgs>((eventArgs) {
      updateStateFromBooking(eventArgs.newBooking);
    });
    globalData.activeBookingListen<ActiveBookingDeletedEventArgs>((eventArgs) {
      rebuild();
    });
    globalData.activeBookingListen<ActiveBookingSeatAddedEventArgs>((eventArgs) {
      numberOfSeat++;
      rebuild();
    });
    globalData.activeBookingListen<ActiveBookingSeatRemovedEventArgs>(
      (eventArgs) {
        numberOfSeat--;
        rebuild();
      },
    );
    globalData.activeBookingListen<ActiveBookingUpdatedEventArgs>((eventArgs) {
      firstName.text = eventArgs.firstName ?? firstName.text;
      lastName.text = eventArgs.lastName ?? lastName.text;
      className.text = eventArgs.className ?? className.text;
    });

    globalData.activeBookingListen<ActiveBookingCreatedEventArgs>((eventArgs) {
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

  @override
  Widget build(BuildContext context) {
    if (!GlobalData().isBookingActive()) {
      return const Text("no active booking");
    }
    return Column(
      children: [
        Divider(
          color: Colors.grey.shade700,
          height: 32,
          indent: 16,
          endIndent: 16,
          thickness: 1,
        ),
        Card(
          color: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text("Buchung ändern", style: TextStyle(fontSize: 20)),
                buildForm(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Form buildForm() {
    final globalData = GlobalData();
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            children: [
              space(height: 32),
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
          space(height: 32),
          IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Sitze bestellt: $numberOfSeat",
                    style: TextStyle(fontSize: 18)),
                VerticalDivider(
                  width: 32,
                ),
                widget.pricePaidWidget,
                VerticalDivider(
                  width: 32,
                ),
                Column(
                  children: [
                    Text("Preisart", style: TextStyle(fontSize: 18)),
                    space(height: 8),
                    Row(
                      children: [
                        DropdownButton(
                          value: priceType,
                          focusColor: Colors.transparent,
                          padding: EdgeInsets.only(left: 8, right: 8),
                          items: <DropdownMenuItem<PriceType>>[
                            for (final PriceType priceType in PriceType.values)
                              DropdownMenuItem(
                                  child: Text(priceType.name),
                                  value: priceType),
                          ],
                          onChanged: (value) => setState(() {
                            if (value == null || value == priceType) return;
                            globalData.updateActiveBooking(
                              priceType: value,
                            );
                            priceType = value;
                          }),
                        ),
                        space(width: 16),
                        // TODO: isAfternoon
                        Text(
                            "${priceType.calculatePrice(
                              isAfternoon: false,
                            )}€ pro Sitz",
                            style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
