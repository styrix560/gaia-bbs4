import "package:bbs4/api/mock_api.dart";
import "package:bbs4/main.dart";
import "package:bbs4/types/booking.dart";
import "package:bbs4/types/booking_time.dart";
import "package:bbs4/types/global_data.dart";
import "package:bbs4/types/price_type.dart";
import "package:bbs4/types/seat.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";

Future<void> testTextField(
  WidgetTester tester,
  String initialData,
  String newValue,
  String Function() getter,
) async {
  print("Selecting $initialData");
  final textField = findEditBookingTextField(initialData);

  expect(textField, findsOne);
  // await tester.tap(textField);
  // await tester.pumpAndSettle();

  print("Editing $initialData");
  await tester.enterText(textField, newValue);
  await tester.pumpAndSettle();

  expect(newValue, getter());
}

Finder findEditBookingTextField(String initialData) {
  return find.ancestor(
    of: find.text(initialData),
    matching: find.byType(TextFormField),
  );
}

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await appInitialization();
  final api = MockApi();
  GlobalData.api = api;

  testWidgets("Creating a booking", (tester) async {
    final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

    await tester.pumpWidget(MaterialApp(
      scaffoldMessengerKey: scaffoldKey,
      home: const MainApp(),
    ));

    final globalData = GlobalData(BookingTime.afternoon);

    await clickSeat(tester, "R1 P1");

    print("finding save button");
    final saveButton = find.text("Buchung speichern");
    expect(saveButton, findsOne);

    print("tapping save button");
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(globalData.bookings.value.length, 1);
  });

  testWidgets("Edit booking names and comments", (tester) async {
    api.internalBookings["Nachmittag"] = [
      Booking(
        "id",
        "firstname",
        "lastname",
        "classname",
        {
          Seat(0, 1),
        },
        0,
        PriceType.normal,
        "comments",
      ),
    ];

    final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

    await tester.pumpWidget(MaterialApp(
      scaffoldMessengerKey: scaffoldKey,
      home: const MainApp(),
    ));

    final globalData = GlobalData();
    // delete bookings to avoid merging
    globalData.bookings.value = [];
    await globalData.loadBookings();
    await Future.delayed(const Duration(seconds: 1), () {});
    await tester.pumpAndSettle();

    expect(globalData.activeBooking.value, null);
    expect(globalData.bookings.value.length, 1);

    await clickSeat(tester, "lastname");
    expect(globalData.activeBooking.value != null, true);
    expect(globalData.bookings.value.length, 0);

    final activeBooking = globalData.activeBooking;
    await testTextField(
      tester,
      "firstname",
      "Max",
      () => activeBooking.value!.firstName,
    );
    await testTextField(
      tester,
      "lastname",
      "Mustermann",
      () => activeBooking.value!.lastName,
    );
    await testTextField(
      tester,
      "classname",
      "Musterklasse",
      () => activeBooking.value!.className,
    );
    await testTextField(
      tester,
      "comments",
      "Muster-Kommentare\nmit neuer Zeile!",
      () => activeBooking.value!.comments,
    );
    print("saving booking");
    final saveButton = find.text("Buchung speichern");
    expect(saveButton, findsOne);

    final scrollView = find.byKey(const Key("BookingsViewScroller"));
    await tester.dragUntilVisible(
      saveButton,
      scrollView,
      const Offset(0, -250),
    );

    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(globalData.bookings.value.length, 1);
    expect(
      globalData.bookings.value.first,
      Booking(
        "id",
        "Max",
        "Mustermann",
        "Musterklasse",
        {
          const Seat(0, 1),
        },
        0,
        PriceType.normal,
        "Muster-Kommentare\nmit neuer Zeile!",
      ),
    );
  });
}

Future<void> wait([int seconds = 5]) async {
  await Future.delayed(Duration(seconds: seconds), () {});
}

Future<void> clickSeat(WidgetTester tester, String seatText) async {
  print("finding seat");
  final seat = find.text(seatText);
  expect(seat, findsOne);

  print("tapping seat");
  await tester.tap(seat);
  await tester.pumpAndSettle();
}
