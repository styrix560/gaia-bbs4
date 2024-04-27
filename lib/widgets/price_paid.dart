import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:supernova/supernova.dart";

import "../types.dart";

class PaidPriceWidget extends HookWidget {
  const PaidPriceWidget({super.key});


  // TODO(styrix): isAfternoon
  int get pricePerSeat =>
      GlobalData().activeBooking!.priceType.calculatePrice(isAfternoon: false);

  @override
  Widget build(BuildContext context) {
    final globalData = GlobalData();
    final pricePaid = useState(globalData.activeBooking?.pricePaid ?? 0);
    final controller =
    useTextEditingController(text: pricePaid.value.toString());

    useEffect(() {
      void listener() {
        globalData.updateActiveBooking(pricePaid: pricePaid.value);
        controller.text = pricePaid.value.toString();
      }

      pricePaid.addListener(listener);
      return () => pricePaid.removeListener(listener);
    });

    useEffect(() {
      void listener() {
        if (!globalData.isBookingActive) return;
        if (globalData.activeBooking!.pricePaid != pricePaid.value) {
          pricePaid.value = globalData.activeBooking!.pricePaid;
        }
        if (controller.text != pricePaid.value.toString()) {
          controller.text = pricePaid.value.toString();
        }
      }

      globalData.addListener(listener);
      return () {
        logger.debug("removed global listener");
        globalData.removeListener(listener);
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
