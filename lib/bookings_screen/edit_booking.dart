import 'package:bbs4/types.dart';
import 'package:bbs4/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EditBookingWidget extends HookWidget {
  final Booking? booking;
  final void Function(Booking) onInput;

  const EditBookingWidget(this.booking, this.onInput, {super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final lastName = useTextEditingController(text: booking?.lastName);

    if (booking == null) {
      return const Text('no active booking');
    } else {
      return Form(
        key: formKey,
        onChanged: () {
          onInput(Booking(
              booking!.id,
              booking!.firstName,
              lastName.text,
              booking!.className,
              booking!.seats,
              booking!.paidAmount,
              booking!.priceType));
        },
        child: Row(
          children: [
            context.space(0, 32),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: lastName,
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
