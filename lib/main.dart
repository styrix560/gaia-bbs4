import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:supernova/supernova.dart";

import "widgets/bookings_view.dart";
import "wrapper.dart";

// TODO(styrix): add printing of overview
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initSupernova(
    shouldInitializeTimeMachine: false,
    minLogLevel: kDebugMode ? LogLevel.trace : LogLevel.config,
  );

  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends HookWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrapper("Buchungsübersicht", BookingsView(isAfternoon: false));
  }
}
