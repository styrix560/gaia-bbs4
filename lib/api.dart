import "package:gsheets/gsheets.dart";
import "package:supernova/supernova.dart";

import "types/booking.dart";
import "types/config.dart";
import "types/price_type.dart";
import "types/seat.dart";

class Api {
  static final _gsheets = GSheets(Config.getApiSecret());

  static Future<List<Booking>> getBookings(String sheetName) async {
    logger.info("getting Bookings from api");
    final spreadsheet = await _gsheets.spreadsheet(Config.getSheetId());
    final worksheet = spreadsheet.worksheetByTitle(sheetName);
    final rows = await worksheet?.cells.allRows();

    if (rows == null) return [];

    final bookings = <Booking>[];

    for (final row in rows) {
      final values = row
          .map(
            (e) => e.value,
          )
          .toList();
      final newBooking = Booking(
        values[0],
        values[2],
        values[1],
        values[3],
        values[4].split(";").map(Seat.fromString).toSet(),
        values[5].toInt(),
        PriceType.values.byName(values[6]),
        values.length == 8 ? values[7] : "",
      );
      bookings.add(newBooking);
    }
    logger.info("done.");
    return bookings;
  }

  static Future<void> writeBookings(
      String sheetName, List<Booking> bookings) async {
    logger.info("writing bookings to api");
    final spreadsheet = await _gsheets.spreadsheet(Config.getSheetId());
    final worksheet = spreadsheet.worksheetByTitle(sheetName) ??
        await spreadsheet.addWorksheet(sheetName);

    final rows = <List<String>>[];
    for (final booking in bookings) {
      final row = <String>[
        booking.id,
        booking.lastName,
        booking.firstName,
        booking.className,
        booking.seats.join(";"),
        booking.pricePaid.toString(),
        booking.priceType.name,
        booking.comments,
      ];
      rows.add(row);
    }
    await worksheet.clear();
    if (rows.isNotEmpty) {
      await worksheet.values.insertRows(1, rows);
    }
    logger.info("done.");
  }
}
