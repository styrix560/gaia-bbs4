import 'package:bbs4/grid_definition.dart';
import 'package:bbs4/types.dart';
import 'package:bbs4/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:uuid/uuid.dart';

import 'bookings_screen/bookings_view.dart';

void main() {
  runApp(MaterialApp(home: MainApp()));
}

class MainApp extends HookWidget {
  MainApp({super.key});

  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Wrapper(
        "Buchungsübersicht", SingleChildScrollView(child: BookingsView(false)));
  }
}
