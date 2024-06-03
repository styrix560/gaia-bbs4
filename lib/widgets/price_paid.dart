import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:supernova/supernova.dart";

import "../types/global_data.dart";
import "../types/price_type.dart";

class PaidPriceWidget extends HookWidget {
  const PaidPriceWidget({super.key});

  int get pricePerSeat => GlobalData()
      .activeBooking
      .value!
      .priceType
      .calculatePrice(GlobalData.currentBookingTime.value);

  @override
  Widget build(BuildContext context) {
    final globalData = GlobalData();
    final activeBooking = globalData.activeBooking.value;
    final pricePaid = useState(activeBooking?.pricePaid ?? 0);
    final controller =
        useTextEditingController(text: pricePaid.value.toString());

    useEffect(
      () {
        void pricePaidListener() {
          final globalData = GlobalData();
          globalData.updateActiveBooking(pricePaid: pricePaid.value);
          controller.text = pricePaid.value.toString();
        }

        void controllerListener() {
          if (!controller.text.isInt) return;
          final newValue = controller.text.toInt();
          if (newValue < 0) return;
          pricePaid.value = newValue;
        }

        pricePaid.addListener(pricePaidListener);
        controller.addListener(controllerListener);
        return () {
          pricePaid.removeListener(pricePaidListener);
          controller.addListener(controllerListener);
        };
      },
      [],
    );

    useEffect(() {
      void globalDataListener() {
        final globalData = GlobalData();
        final activeBooking = globalData.activeBooking.value;
        if (!globalData.isBookingActive) return;
        if (activeBooking!.pricePaid != pricePaid.value) {
          pricePaid.value = activeBooking.pricePaid;
        }
        if (controller.text != pricePaid.value.toString()) {
          controller.text = pricePaid.value.toString();
        }
      }

      globalData.activeBooking.addListener(globalDataListener);
      return () => globalData.activeBooking.removeListener(globalDataListener);
    }, [GlobalData.currentBookingTime.value]);
    useListenable(GlobalData.currentBookingTime);

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
