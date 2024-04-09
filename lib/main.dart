import 'package:bbs4/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:uuid/uuid.dart';

import 'bookings_screen/bookings_view.dart';

void main() {
  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends HookWidget {
  const MainApp({super.key});

  final uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return const Wrapper("Buchungsübersicht", BookingsView(isAfternoon: false));
  }
}
