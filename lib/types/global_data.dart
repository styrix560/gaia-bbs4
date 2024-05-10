import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:supernova/supernova.dart";

import "../api.dart";
import "../utils.dart";
import "booking.dart";
import "booking_time.dart";
import "price_type.dart";
import "seat.dart";

class GlobalData extends ChangeNotifier {
  // TODO(styrix): use seperate ChangeNotifiers for activeBooking and bookings
  factory GlobalData(BookingTime bookingTime) {
    if (!datas.containsKey(bookingTime)) {
      datas[bookingTime] = GlobalData._internal(
        [],
        null,
        bookingTime,
      );
    }
    return datas[bookingTime]!;
  }

  GlobalData._internal(
    this._bookings,
    this._activeBooking,
    this.bookingTime,
  ) {
    loadBookings();
  }

  static final Map<BookingTime, GlobalData> datas = {};

  final BookingTime bookingTime;
  List<Booking> _bookings;
  Booking? _activeBooking;

  final isTransactionInProgress = ValueNotifier(false);
  final Uuid uuid = const Uuid();

  Booking? get activeBooking => _activeBooking;

  List<Booking> get bookings => _bookings;

  bool get isBookingActive => _activeBooking != null;

  void pushBookings() {
    // TODO(styrix): add merging of bookings
    isTransactionInProgress.value = true;
    // ignore: prefer-async-await
    Api.writeBookings(bookingTime.germanName, _bookings)
        .then((_) => snackbar("Buchungen erfolgreich geschrieben"))
        .onError(
      (error, stackTrace) {
        logger.error("error pushing changes to db", error, stackTrace);
        snackbar("Fehler beim Schreiben der Buchungen");
      },
    ).then((_) {
      isTransactionInProgress.value = false;
    });
  }

  void loadBookings() {
    isTransactionInProgress.value = true;
    notifyListeners();
    // ignore: prefer-async-await
    Api.getBookings(bookingTime.germanName)
        .then((value) {
          _bookings = value;
          notifyListeners();
        })
        .then((_) => snackbar("Buchungen erfolreich geladen"))
        .onError((error, stackTrace) {
          logger.error("error loading bookings", error, stackTrace);
          snackbar(
            "Fehler beim Laden der Buchungen. Ist Internet aktiviert und "
            "geht die Uhr richtig?",
          );
        })
        .then((value) {
          isTransactionInProgress.value = false;
        });
  }

  void updateActiveBooking({
    String? firstName,
    String? lastName,
    String? className,
    Set<Seat>? seats,
    int? pricePaid,
    PriceType? priceType,
    String? comments,
  }) {
    final newBooking = Booking(
      _activeBooking!.id,
      firstName ?? activeBooking!.firstName,
      lastName ?? activeBooking!.lastName,
      className ?? activeBooking!.className,
      seats ?? activeBooking!.seats,
      pricePaid ?? activeBooking!.pricePaid,
      priceType ?? activeBooking!.priceType,
      comments ?? activeBooking!.comments,
    );

    if (_activeBooking == newBooking) return;

    logger.debug("updated active booking");

    _activeBooking = newBooking;

    notifyListeners();
  }

  List<Booking> getBookingsContainingSeat(Seat seat) {
    return _bookings.where((element) => element.seats.contains(seat)).toList();
  }

  void changeActiveBooking(Booking? newBooking) {
    if (isTransactionInProgress.value) {
      snackbar("Bitte warten bis die Transaktion abgeschlossen ist.");
      return;
    }
    logger.debug("changed active booking from id "
        "${_activeBooking?.id} to ${newBooking?.id}");
    if (isBookingActive) {
      _bookings.add(_activeBooking!);
    }
    _bookings.remove(newBooking);
    _activeBooking = newBooking;
    notifyListeners();
  }

  void initializeActiveBooking(Seat firstSeat) {
    if (isTransactionInProgress.value) {
      snackbar("Bitte warten bis die Transaktion abgeschlossen ist.");
      return;
    }
    assert(activeBooking == null);
    logger.debug("initialize active booking");
    _activeBooking =
        Booking(uuid.v4(), "", "", "", {firstSeat}, 0, PriceType.normal, "");
    notifyListeners();
  }
}
