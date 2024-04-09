import 'package:bbs4/types.dart';
import 'package:bbs4/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditBookingWidget extends StatelessWidget {
  final Booking? booking;
  final void Function() onInput;
  final formKey = GlobalKey<FormState>();

  EditBookingWidget(this.booking, this.onInput, {super.key});

  @override
  Widget build(BuildContext context) {
    if (booking == null) {
      return const Text('no active booking');
    } else {
      return Form(
        key: formKey,
        onChanged: () {
          this.booking.lastName =
        },
        child: Row(
          children: [
            context.space(0, 32),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(

                  initialValue: booking!.lastName,
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
