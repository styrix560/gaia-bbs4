import "package:flutter/material.dart";
import "package:supernova/supernova.dart";

import "../event_notifier.dart";
import "../types.dart";

class PaidPriceWidget extends StatefulWidget {
  const PaidPriceWidget({super.key});

  @override
  State<PaidPriceWidget> createState() => _PaidPriceWidgetState();
}

class _PaidPriceWidgetState extends State<PaidPriceWidget> {
  late TextEditingController controller;
  ValueNotifier<int> pricePaid = ValueNotifier(0);
  int pricePerSeat = 20;

  final List<VoidCallback> removeCallbacks = [];

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: "0");

    controller.addListener(() {
      setState(() {
        final valueChanged =
            pricePaid.value.toString() != controller.value.text;
        if (valueChanged && controller.value.text.isInt) {
          pricePaid.value = controller.value.text.toInt();
        }
      });
    });
    final globalData = GlobalData();

    pricePaid.addListener(() {
      controller.text = pricePaid.value.toString();
      globalData.updateActiveBooking(pricePaid: pricePaid.value);
    });

    removeCallbacks.add(globalData
        .activeBookingListen<ActiveBookingActivatedEventArgs>((eventArgs) {
      setState(() {
        pricePaid.value = eventArgs.newBooking.pricePaid;
        // TODO: isAfternoon
        pricePerSeat =
            eventArgs.newBooking.priceType.calculatePrice(isAfternoon: false);
      });
    }));
    removeCallbacks.add(globalData
        .activeBookingListen<ActiveBookingUpdatedEventArgs>((eventArgs) {
      pricePaid.value = eventArgs.pricePaid ?? pricePaid.value;
      // TODO: isAfternoon
      pricePerSeat = eventArgs.priceType?.calculatePrice(isAfternoon: false) ??
          pricePerSeat;
    }));
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
    pricePaid.dispose();

    for (final removeListener in removeCallbacks) {
      try {
        removeListener.call();
      } on Exception catch (e) {
        logger.error(e.toString());
      }
    }
  }

  void decrementPrice() {
    if (pricePaid.value <= 0) return;
    setState(() {
      pricePaid.value = ((pricePaid.value - 1) ~/ pricePerSeat) * pricePerSeat;
    });
  }

  void incrementPrice() {
    setState(() {
      pricePaid.value = (pricePaid.value ~/ pricePerSeat + 1) * pricePerSeat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Bezahlt", style: TextStyle(fontSize: 18)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: incrementPrice,
              icon: Icon(
                size: 35,
                Icons.add,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: TextFormField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        filled: !controller.text.isInt,
                        fillColor: Colors.red,
                      ),
                      style: TextStyle(fontSize: 18)),
                ),
                Text("€"),
              ],
            ),
            IconButton(
              onPressed: decrementPrice,
              icon: Icon(
                size: 35,
                Icons.remove,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
