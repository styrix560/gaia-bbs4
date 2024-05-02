import "package:encrypt/encrypt.dart";
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

    final key = Config.getAesKey();
    final encrypter = Encrypter(AES(key, padding: null));

    final spreadsheet = await _gsheets.spreadsheet(Config.getSheetId());
    final worksheet = spreadsheet.worksheetByTitle(sheetName);
    final rows = await worksheet?.cells.allRows();

    if (rows == null) return [];

    final bookings = <Booking>[];

    for (final row in rows) {
      final iv = IV.fromBase64(row[8].value.replaceAll('"', ""));
      final values = row.getRange(0, 8).map(
        (cell) {
          final cellValue = cell.value.replaceAll('"', "");
          logger.debug("cellValue", (cell.value, cellValue));
          if (cellValue == "") return "";
          return encrypter.decrypt64(cellValue, iv: iv);
        },
      ).toList();
      logger.debug("values", values);
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

    final key = Config.getAesKey();
    final encrypter = Encrypter(AES(key, padding: null));

    final spreadsheet = await _gsheets.spreadsheet(Config.getSheetId());
    final worksheet = spreadsheet.worksheetByTitle(sheetName) ??
        await spreadsheet.addWorksheet(sheetName);

    final rows = <List<String>>[];
    for (final booking in bookings) {
      final iv = IV.fromLength(16);

      final row = <String>[
        booking.id,
        booking.lastName,
        booking.firstName,
        booking.className,
        booking.seats.join(";"),
        booking.pricePaid.toString(),
        booking.priceType.name,
        booking.comments,
      ].map(
        (e) {
          if (e == "") return "";
          return encrypter.encrypt(e, iv: iv).base64;
        },
      ).toList();
      row.add(iv.base64);
      rows.add(row.map((e) => '"$e"').toList());
    }
    await worksheet.clear();
    if (rows.isNotEmpty) {
      await worksheet.values.insertRows(1, rows);
    }
    logger.info("done.");
  }
}
