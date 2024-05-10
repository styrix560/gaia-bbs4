import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:supernova/supernova.dart";

import "../types/booking_time.dart";
import "../types/global_data.dart";
import "../types/price_type.dart";

class PaidPriceWidget extends HookWidget {
  const PaidPriceWidget(this.bookingTime, {super.key});

  final BookingTime bookingTime;

  int get pricePerSeat => GlobalData(bookingTime)
      .activeBooking
      .value!
      .priceType
      .calculatePrice(bookingTime);

  @override
  Widget build(BuildContext context) {
    final globalData = GlobalData(bookingTime);
    final activeBooking = globalData.activeBooking.value;
    final pricePaid = useState(activeBooking?.pricePaid ?? 0);
    final controller =
        useTextEditingController(text: pricePaid.value.toString());

    useEffect(() {
      void pricePaidListener() {
        globalData.updateActiveBooking(pricePaid: pricePaid.value);
        controller.text = pricePaid.value.toString();
      }

      void globalDataListener() {
        if (!globalData.isBookingActive) return;
        if (activeBooking!.pricePaid != pricePaid.value) {
          pricePaid.value = activeBooking.pricePaid;
        }
        if (controller.text != pricePaid.value.toString()) {
          controller.text = pricePaid.value.toString();
        }
      }

      void controllerListener() {
        if (!controller.text.isInt) return;
        final newValue = controller.text.toInt();
        if (newValue < 0) return;
        pricePaid.value = newValue;
      }

      pricePaid.addListener(pricePaidListener);
      globalData.activeBooking.addListener(globalDataListener);
      controller.addListener(controllerListener);
      return () {
        globalData.activeBooking.removeListener(globalDataListener);
        pricePaid.removeListener(pricePaidListener);
        controller.removeListener(controllerListener);
      };
    });

    void decrementPrice() {
      if (pricePaid.value <= 0) return;
      if (pricePerSeat == 0) {
        pricePaid.value = 0;
        return;
      }
      pricePaid.value = ((pricePaid.value - 1) ~/ pricePerSeat) * pricePerSeat;
    }

    void incrementPrice() {
      if (pricePerSeat == 0) return;
      pricePaid.value = (pricePaid.value ~/ pricePerSeat + 1) * pricePerSeat;
    }

    return Column(
      children: [
        const Text("Bezahlt", style: TextStyle(fontSize: 18)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: incrementPrice,
              icon: const Icon(
                size: 35,
                Icons.add,
              ),
            ),
            Row(
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
                      style: const TextStyle(fontSize: 18)),
                ),
                const Text("€"),
              ],
            ),
            IconButton(
              onPressed: decrementPrice,
              icon: const Icon(
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
