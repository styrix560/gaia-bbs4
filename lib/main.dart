import "package:bbs4/types/config.dart";
import "package:bbs4/types/global_data.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:supernova/supernova.dart";

import "api/sheets_api.dart";
import "widgets/bookings_view.dart";
import "widgets/overview.dart";

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

Future<bool> appInitialization() async {
  await initSupernova(
    shouldInitializeTimeMachine: false,
    minLogLevel: kDebugMode ? LogLevel.trace : LogLevel.config,
  );

  return Config.loadConfig("assets/config.json");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final configFound = await appInitialization();

  GlobalData.api = SheetsApi();

  runApp(MaterialApp(
    scaffoldMessengerKey: scaffoldKey,
    home: configFound ? const MainApp() : const ConfigMissingApp(),
  ));
}

class ConfigMissingApp extends StatelessWidget {
  const ConfigMissingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Die Konfigurationsdateien wurden nicht gefunden. "
            "Bitte die Dateien unter data/flutter_assets/assets einfügen "
            "und die Applikation neustarten"),
      ),
    );
  }
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
          Tab(text: "Buchungen"),
          Tab(text: "Überblick"),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: TabBarView(controller: tabController, children: [
          const SingleChildScrollView(child: BookingsView()),
          OverviewWidget(tabController),
        ]),
      ),
    );
  }
}
