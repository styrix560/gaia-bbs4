import "package:flutter/material.dart";
import "package:uuid/uuid.dart";

import "booking.dart";
import "booking_time.dart";
import "price_type.dart";
import "seat.dart";

class GlobalData extends ChangeNotifier {
  factory GlobalData(BookingTime bookingTime) {
    switch (bookingTime) {
      case BookingTime.afternoon:
        return _afternoon;
      case BookingTime.evening:
        return _evening;
    }
  }

  GlobalData._internal(this._bookings, this._activeBooking);

  static final GlobalData _afternoon = GlobalData._internal(
    [
      Booking(
        "id",
        "Max",
        "Mustermann",
        "7A",
        {const Seat(0, 9), const Seat(0, 10), const Seat(0, 11)},
        40,
        PriceType.normal,
      ),
      Booking(
        "id2",
        "VERY",
        "VIP",
        "important class",
        {const Seat(0, 0), const Seat(0, 1)},
        40,
        PriceType.normal,
      ),
    ],
    null,
  );
  static final GlobalData _evening = GlobalData._internal([], null);

  final Uuid uuid = const Uuid();

  List<Booking> _bookings;
  Booking? _activeBooking;

  Booking? get activeBooking => _activeBooking;

  List<Booking> get bookings => _bookings;

  bool get isBookingActive => _activeBooking != null;

  void updateActiveBooking({
    String? firstName,
    String? lastName,
    String? className,
    Set<Seat>? seats,
    int? pricePaid,
    PriceType? priceType,
  }) {
    final newBooking = Booking(
      _activeBooking!.id,
      firstName ?? activeBooking!.firstName,
      lastName ?? activeBooking!.lastName,
      className ?? activeBooking!.className,
      seats ?? activeBooking!.seats,
      pricePaid ?? activeBooking!.pricePaid,
      priceType ?? activeBooking!.priceType,
    );

    if (_activeBooking == newBooking) return;

    _activeBooking = newBooking;

    notifyListeners();
  }

  List<Booking> getBookingsContainingSeat(Seat seat) {
    return bookings.where((element) => element.seats.contains(seat)).toList();
  }

  void changeActiveBooking(Booking? newBooking) {
    if (isBookingActive) {
      bookings.add(_activeBooking!);
    }
    bookings.remove(newBooking);
    _activeBooking = newBooking;
    notifyListeners();
  }

  void initActiveBooking(Seat firstSeat) {
    assert(activeBooking == null);
    _activeBooking = Booking(
      uuid.v4(),
      "",
      "",
      "",
      {firstSeat},
      0,
      PriceType.normal,
    );
    notifyListeners();
  }
}
