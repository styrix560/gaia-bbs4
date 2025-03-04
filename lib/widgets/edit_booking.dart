import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../main.dart";
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
    final globalData = GlobalData();
    final activeBooking = globalData.activeBooking.value!;
    final bookingTime = GlobalData.currentBookingTime;

    final numberOfSeat = activeBooking.seats.length;
    final priceType = useState(activeBooking.priceType);

    final name = useTextEditingController(text: activeBooking.name);
    final className = useTextEditingController(text: activeBooking.className);
    final comments = useTextEditingController(text: activeBooking.comments);

    void onPriceTypeChanged(PriceType? value) {
      if (value == null || value == priceType.value) return;
      globalData.updateActiveBooking(
        priceType: value,
      );
      priceType.value = value;
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
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      autofocus: true,
                      decoration: const InputDecoration(label: Text("Name")),
                      controller: name,
                      onChanged: (value) =>
                          globalData.updateActiveBooking(name: value),
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
                  Column(
                    children: [
                      Text(
                        "Sitze bestellt: ${numberOfSeat}",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Gesamtpreis: ${numberOfSeat * priceType.value.calculatePricePerSeat(GlobalData.currentBookingTime.value)}€",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Zu bezahlen: ${numberOfSeat * priceType.value.calculatePricePerSeat(GlobalData.currentBookingTime.value) - activeBooking!.pricePaid}€",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
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
                            "${priceType.value.calculatePricePerSeat(
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
                Row(
                  children: [
                    const Spacer(),
                    FilledButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.red.shade600),
                      ),
                      onPressed: () async => deleteBookingDialog(context),
                      child: const Text("Buchung löschen"),
                    ),
                  ],
                ),
                buildForm(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Future<void> deleteBookingDialog(BuildContext context) async {
  final globalData = GlobalData();
  final answer = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Buchung löschen"),
      content: const Text("Diese Aktion ist unwiderruflich. Fortfahren?"),
      actions: [
        FilledButton(
          onPressed: () => navigatorKey.currentState!.pop(true),
          child: const Text("Ja"),
        ),
        FilledButton(
          onPressed: () => navigatorKey.currentState!.pop(false),
          child: const Text("Nein"),
        ),
      ],
    ),
  );
  if (answer ?? false) {
    globalData.deleteActiveBooking();
  }
}
