import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../types/booking_time.dart";
import "../types/global_data.dart";
import "../types/price_type.dart";
import "../utils.dart";
import "price_paid.dart";

class EditBookingWidget extends HookWidget {
  const EditBookingWidget(this.bookingTime, {super.key});

  final BookingTime bookingTime;

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final rebuild = useRebuild();
    final globalData = GlobalData(bookingTime);

    final numberOfSeat = useState(globalData.activeBooking?.seats.length ?? 0);
    final priceType =
        useState(globalData.activeBooking?.priceType ?? PriceType.normal);

    final lastName = useTextEditingController();
    final firstName = useTextEditingController();
    final className = useTextEditingController();

    void onPriceTypeChanged(PriceType? value) {
      if (value == null || value == priceType.value) return;
      globalData.updateActiveBooking(
        priceType: value,
      );
      priceType.value = value;
    }

    void updateState() {
      firstName.text = globalData.activeBooking?.firstName ?? firstName.text;
      lastName.text = globalData.activeBooking?.lastName ?? lastName.text;
      className.text = globalData.activeBooking?.className ?? className.text;
      numberOfSeat.value = globalData.activeBooking?.seats.length ?? 0;
      priceType.value = globalData.activeBooking?.priceType ?? PriceType.normal;
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
      final globalData = GlobalData(bookingTime);
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
                  Text("Sitze bestellt: ${numberOfSeat.value}",
                      style: const TextStyle(fontSize: 18)),
                  const VerticalDivider(
                    width: 32,
                  ),
                  PaidPriceWidget(bookingTime),
                  const VerticalDivider(
                    width: 32,
                  ),
                  Column(
                    children: [
                      const Text("Preisart", style: TextStyle(fontSize: 18)),
                      space(),
                      Row(
                        children: [
                          DropdownButton(
                            value: priceType.value,
                            focusColor: Colors.transparent,
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            items: <DropdownMenuItem<PriceType>>[
                              for (final PriceType priceType
                                  in PriceType.values)
                                DropdownMenuItem(
                                  value: priceType,
                                  child: Text(priceType.germanName),
                                ),
                            ],
                            onChanged: onPriceTypeChanged,
                          ),
                          space(width: 16),
                          Text(
                              "${priceType.value.calculatePrice(
                                bookingTime,
                              )}€ pro Sitz",
                              style: const TextStyle(fontSize: 18)),
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

    if (!GlobalData(bookingTime).isBookingActive) {
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
