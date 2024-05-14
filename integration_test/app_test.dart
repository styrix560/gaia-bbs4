import "package:bbs4/api/mock_api.dart";
import "package:bbs4/main.dart";
import "package:bbs4/types/global_data.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Creating a booking", (tester) async {
    await appInitialization();
    GlobalData.api = MockApi();

    final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

    await tester.pumpWidget(MaterialApp(
      scaffoldMessengerKey: scaffoldKey,
      home: const MainApp(),
    ));

    final globalData = GlobalData();

    final seat = find.text("R1 P1");
    print("finding seat");
    expect(seat, findsOne);

    print("tapping seat");
    await tester.tap(seat);
    await tester.pumpAndSettle();

    print("finding button");
    final saveButton = find.text("Buchung speichern");
    expect(saveButton, findsOne);

    print("tapping button");
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(globalData.bookings.value.length, 1);
  });
}
