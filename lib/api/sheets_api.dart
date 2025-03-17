import "package:encrypt/encrypt.dart";
import "package:gsheets/gsheets.dart";
import "package:path_provider/path_provider.dart";
import "package:supernova/supernova.dart";
import "package:supernova/supernova_io.dart";

import "../types/booking.dart";
import "../types/config.dart";
import "../types/price_type.dart";
import "../types/seat.dart";
import "api.dart";

Future<void> log(String message, Exception e) async {
  logger.error(message, e);
  final directory = await getApplicationSupportDirectory();
  final file = directory ~/ "error.log";
  final rwFile = file.openSync(mode: FileMode.writeOnlyAppend);
  final now = DateTime.now();
  rwFile.writeStringSync("error timestamp: $now\n$e\n\n");
}

class SheetsApi extends Api {
  static final _gsheets = GSheets(Config.getApiSecret());

  @override
  Future<List<Booking>> getBookings(String sheetName) async {
    logger.info("getting Bookings from api");

    final key = Config.getAesKey();
    final encrypter = Encrypter(AES(key, padding: null));

    final List<List<Cell>>? rows;

    try {
      final spreadsheet = await _gsheets.spreadsheet(Config.getSheetId());
      final worksheet = spreadsheet.worksheetByTitle(sheetName);
      rows = await worksheet?.cells.allRows();
    } on Exception catch (e) {
      await log("Error fetching bookings", e);
      rethrow;
    }

    if (rows == null) return [];

    final bookings = <Booking>[];

    for (final row in rows) {
      final iv = IV.fromBase64(row[7].value.replaceAll('"', ""));
      final values = row.getRange(0, 7).map(
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
        values[1],
        values[2],
        values[3].split(";").map(Seat.fromString).toSet(),
        values[4].toInt(),
        PriceType.values.byName(values[5]),
        values.length == 8 ? values[6] : "",
      );
      bookings.add(newBooking);
    }
    logger.info("done.");
    return bookings;
  }

  Future<void> writeBookings(String sheetName, List<Booking> bookings) async {
    logger.info("writing bookings to api");

    final key = Config.getAesKey();
    final encrypter = Encrypter(AES(key, padding: null));

    final rows = <List<String>>[];
    for (final booking in bookings) {
      final iv = IV.fromLength(16);

      final row = <String>[
        booking.id,
        booking.name,
        booking.className,
        booking.seats.map((seat) => seat.toDatabaseString()).join(";"),
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
    try {
      final spreadsheet = await _gsheets.spreadsheet(Config.getSheetId());
      final worksheet = spreadsheet.worksheetByTitle(sheetName) ??
          await spreadsheet.addWorksheet(sheetName);

      await worksheet.clear();
      if (rows.isNotEmpty) {
        await worksheet.values.insertRows(1, rows);
      }
    } on Exception catch (e) {
      await log("Error writing bookings", e);
      rethrow;
    }
    logger.info("done.");
  }
}
