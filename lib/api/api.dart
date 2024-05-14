import "package:supernova/supernova.dart";

import "../types/booking.dart";

abstract class Api {
  Future<List<Booking>> getBookings(String sheetName);

  Future<void> writeBookings(String sheetName, List<Booking> bookings);
}
