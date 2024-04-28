import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:supernova/supernova.dart";

import "types/booking_time.dart";
import "widgets/bookings_view.dart";

// TODO(styrix): add printing of overview
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initSupernova(
    shouldInitializeTimeMachine: false,
    minLogLevel: kDebugMode ? LogLevel.trace : LogLevel.config,
  );

  runApp(const MaterialApp(
    home: MainApp(),
  ));
}

class MainApp extends HookWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Benefiz Buchungs System 4",
          style: TextStyle(fontSize: 15),
        ),
        bottom: TabBar(controller: tabController, tabs: const [
          Tab(text: "Nachmittag"),
          Tab(text: "Abend"),
        ]),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: TabBarView(controller: tabController, children: const [
          SingleChildScrollView(child: BookingsView(BookingTime.afternoon)),
          SingleChildScrollView(child: BookingsView(BookingTime.evening)),
        ]),
      ),
    );
  }
}
