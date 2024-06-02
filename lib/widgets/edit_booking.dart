import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../types/global_data.dart";
import "../types/price_type.dart";
import "../utils.dart";
import "custom_menu_button.dart";
import "price_paid.dart";

class EditBookingWidget extends HookWidget {
  const EditBookingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final rebuild = useRebuild();
    final globalData = GlobalData();
    final activeBooking = globalData.activeBooking.value;
    final bookingTime = GlobalData.currentBookingTime;

    final numberOfSeat = useState(activeBooking?.seats.length ?? 0);
    final priceType = useState(activeBooking?.priceType ?? PriceType.normal);

    final lastName = useTextEditingController();
    final firstName = useTextEditingController();
    final className = useTextEditingController();
    final comments = useTextEditingController();

    void onPriceTypeChanged(PriceType? value) {
      if (value == null || value == priceType.value) return;
      globalData.updateActiveBooking(
        priceType: value,
      );
      priceType.value = value;
    }

    void updateState() {
      final activeBooking = globalData.activeBooking.value;
      firstName.text = activeBooking?.firstName ?? firstName.text;
      lastName.text = activeBooking?.lastName ?? lastName.text;
      className.text = activeBooking?.className ?? className.text;
      comments.text = activeBooking?.comments ?? comments.text;
      numberOfSeat.value = activeBooking?.seats.length ?? 0;
      priceType.value = activeBooking?.priceType ?? PriceType.normal;
    }

    useEffect(() {
      void listenable() {
        updateState();
        rebuild();
      }

      globalData.activeBooking.addListener(listenable);
      return () => globalData.activeBooking.removeListener(listenable);
    }, [GlobalData.currentBookingTime.value]);
    useListenable(GlobalData.currentBookingTime);

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
                          globalData.updateActiveBooking(firstName: value),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      decoration:
                          const InputDecoration(label: Text("Nachname")),
                      controller: lastName,
                      onChanged: (value) =>
                          globalData.updateActiveBooking(lastName: value),
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
                          globalData.updateActiveBooking(className: value),
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
                  Text(
                    "Sitze bestellt: ${numberOfSeat.value}",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const VerticalDivider(
                    width: 32,
                  ),
                  const PaidPriceWidget(),
                  const VerticalDivider(
                    width: 32,
                  ),
                  Column(
                    children: [
                      const Text("Preisart", style: TextStyle(fontSize: 18)),
                      space(),
                      Row(
                        children: [
                          CustomMenuButton(
                            priceType.value,
                            PriceType.values,
                            (priceType) => priceType.germanName,
                            onPriceTypeChanged,
                          ),
                          space(width: 16),
                          Text(
                            "${priceType.value.calculatePrice(
                              bookingTime.value,
                            )}€ pro Sitz",
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            space(height: 16),
            TextFormField(
              onChanged: (value) =>
                  globalData.updateActiveBooking(comments: value),
              controller: comments,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: "Kommentare",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      );
    }

    if (!globalData.isBookingActive) {
      return const SizedBox();
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
                const Text("Buchung ändern", style: TextStyle(fontSize: 20)),
                buildForm(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
