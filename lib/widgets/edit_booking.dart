import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../types.dart";
import "../utils.dart";
import "price_paid.dart";

class EditBookingWidget extends HookWidget {
  EditBookingWidget({super.key});

  int numberOfSeat = 0;
  PriceType priceType = PriceType.normal;

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final rebuild = useRebuild();

    final lastName = useTextEditingController();
    final firstName = useTextEditingController();
    final className = useTextEditingController();

    final globalData = GlobalData();

    void updateState() {
      firstName.text = globalData.activeBooking?.firstName ?? firstName.text;
      lastName.text = globalData.activeBooking?.lastName ?? lastName.text;
      className.text = globalData.activeBooking?.className ?? className.text;
      numberOfSeat = globalData.activeBooking?.seats.length ?? 0;
    }

    useEffect(() {
      void listenable() {
        updateState();
        rebuild();
      }

      globalData.addListener(listenable);
      return () => globalData.removeListener(listenable);
    });

    // TODO(styrix560): modularize this
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
                  Text("Sitze bestellt: $numberOfSeat",
                      style: TextStyle(fontSize: 18)),
                  VerticalDivider(
                    width: 32,
                  ),
                  const PaidPriceWidget(),
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
                              for (final PriceType priceType
                                  in PriceType.values)
                                DropdownMenuItem(
                                    child: Text(priceType.name),
                                    value: priceType,
                                ),
                            ],
                            onChanged: (value) {
                              if (value == null || value == priceType) return;
                              globalData.updateActiveBooking(
                                priceType: value,
                              );
                              priceType = value;
                            },
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

    if (!GlobalData().isBookingActive) {
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
}
