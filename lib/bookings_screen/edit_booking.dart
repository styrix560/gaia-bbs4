import 'package:bbs4/types.dart';
import 'package:bbs4/utils.dart';
import 'package:flutter/material.dart';

class EditBookingWidget extends StatefulWidget {
  final ValueNotifier<Booking?> initialBooking;
  final void Function(Booking) onInput;
  final formKey = GlobalKey<FormState>();

  EditBookingWidget(initialBooking, this.onInput, {super.key})
      : initialBooking = ValueNotifier(initialBooking);

  @override
  State<StatefulWidget> createState() {
    return EditBookingWidgetState();
  }
}

class EditBookingWidgetState extends State<EditBookingWidget> {
  late final TextEditingController lastName;

  @override
  Widget build(BuildContext context) {
    if (widget.initialBooking.value == null) {
      return const Text('no active widget.booking');
    } else {
      return Form(
        key: widget.formKey,
        onChanged: () {
          widget.onInput(Booking(
              widget.initialBooking.value!.id,
              widget.initialBooking.value!.firstName,
              lastName.text,
              widget.initialBooking.value!.className,
              widget.initialBooking.value!.seats,
              widget.initialBooking.value!.paidAmount,
              widget.initialBooking.value!.priceType));
        },
        child: Row(
          children: [
            context.space(0, 32),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  key: ValueKey(widget.initialBooking),
                  decoration: InputDecoration(label: Text("Nachname")),
                  controller: lastName,
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    lastName =
        TextEditingController(text: widget.initialBooking.value?.lastName);

    widget.initialBooking.addListener(() {
      if (widget.initialBooking.value == null) {
        // rebuild anyway
        setState(() {});
        return;
      }
      setState(() {
        lastName.text = widget.initialBooking.value?.lastName ?? "";
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    lastName.dispose();
    widget.initialBooking.dispose();
  }
}
