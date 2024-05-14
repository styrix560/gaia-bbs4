import "../types/booking.dart";
import "api.dart";

class MockApi extends Api {
  final Map<String, List<Booking>> internalBookings = {
    "Nachmittag": [],
    "Abend": [],
  };

  @override
  Future<List<Booking>> getBookings(String sheetName) {
    return Future.value(internalBookings[sheetName]);
  }

  @override
  Future<void> writeBookings(String sheetName, List<Booking> bookings) async {
    internalBookings[sheetName] = bookings;
  }
}
