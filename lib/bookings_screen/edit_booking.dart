import 'package:bbs4/types.dart';
import 'package:bbs4/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EditBookingWidget extends HookWidget {
  Booking? booking;

  EditBookingWidget(this.booking);

  @override
  Widget build(BuildContext context) {
    if (booking == null) {
      return const Text('no active booking');
    } else {
      return Row(
        children: [
          context.space(0, 32),
          TextFormField(
            initialValue: booking!.lastName,
          )
        ],
      );
    }
  }
}
