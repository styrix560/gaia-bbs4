import "package:bbs4/types/config.dart";
import "package:bbs4/types/global_data.dart";
import "package:bbs4/widgets/statistics.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_window_close/flutter_window_close.dart";
import "package:supernova/supernova.dart";

import "api/sheets_api.dart";
import "types/seat_layout.dart";
import "utils.dart";
import "widgets/bookings_view.dart";
import "widgets/overview.dart";

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
final navigatorKey = GlobalKey<NavigatorState>();

Future<bool> appInitialization() async {
  await initSupernova(
    shouldInitializeTimeMachine: false,
    minLogLevel: kDebugMode ? LogLevel.trace : LogLevel.config,
  );

  assert(seatLayout['Parkett']!.sum == 555);
  assert(seatLayout['Sparkassen Rang']!.sum == 133);
  assert(maxRowLength == 28);

  return Config.loadConfig("assets/config.json");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final configFound = await appInitialization();

  GlobalData.api = SheetsApi();

  runApp(MaterialApp(
    scaffoldMessengerKey: scaffoldKey,
    navigatorKey: navigatorKey,
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
    final tabController = useTabController(initialLength: 3);

    useEffect(
      () {
        FlutterWindowClose.setWindowShouldCloseHandler(() => onClose(context));
        return null;
      },
      [],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Benefiz Buchungs System 4",
          style: TextStyle(fontSize: 15),
        ),
        bottom: TabBar(controller: tabController, tabs: const [
          Tab(text: "Buchungen"),
          Tab(text: "Überblick"),
          Tab(text: "Statistiken"),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: TabBarView(controller: tabController, children: [
          const SingleChildScrollView(
            key: Key("BookingsViewScroller"),
            child: BookingsView(),
          ),
          OverviewWidget(tabController),
          StatisticsWidget(),
        ]),
      ),
    );
  }
}

Future<bool> onClose(BuildContext context) async {
  final globalData = GlobalData();
  if (globalData.isTransactionInProgress.value) {
    snackbar("Bitte warten bis die Transaktion abgeschlossen ist");
    return false;
  }
  if (globalData.isBookingActive) {
    snackbar("Bitte vor dem Schließen zuerst die aktive Buchung speichern");
    return false;
  }
  final hasChanges = globalData.hasChanges();
  logger.debug("hasChanges", hasChanges);
  if (!hasChanges) {
    return true;
  }
  final shouldClose = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Achtung"),
      content: const Text(
        "Sie sind dabei, dieses Fenster zu schließen. Es liegen"
        " ungespeicherte Änderungen vor. Wenn Sie fortfahren, "
        "gehen diese verloren. Fortfahren?",
      ),
      actions: [
        OutlinedButton(
          onPressed: () => context.pop(true),
          child: const Text(
            "Ja",
          ),
        ),
        FilledButton(
          onPressed: () => context.pop(false),
          child: const Text("Abbrechen"),
        ),
      ],
    ),
  );
  return shouldClose ?? false;
}
