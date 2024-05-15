import "package:flutter/material.dart";
import "package:supernova/supernova.dart";

import "../../utils.dart";
import "../api/api.dart";
import "booking.dart";
import "booking_time.dart";
import "price_type.dart";
import "seat.dart";

class GlobalData {
  factory GlobalData([BookingTime? bookingTime]) =>
      GlobalData.fromTime(bookingTime ?? currentBookingTime.value);

  GlobalData._internal(
    this._bookings,
    this._activeBooking,
    this.bookingTime,
  ) {
    loadBookings();
  }

  factory GlobalData.fromTime(BookingTime bookingTime) {
    if (!globalDataInstances.containsKey(bookingTime)) {
      globalDataInstances[bookingTime] = GlobalData._internal(
        ValueNotifier([]),
        ValueNotifier(null),
        bookingTime,
      );
    }
    return globalDataInstances[bookingTime]!;
  }

  static final Map<BookingTime, GlobalData> globalDataInstances = {};
  static late final Api api;

  void pushBookings() {
    isTransactionInProgress.value = true;
    // ignore: prefer-async-await
    api
        .writeBookings(bookingTime.germanName, bookings.value)
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
    api
        .getBookings(bookingTime.germanName)
        .then((value) {
          bookings.value = value;
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

  static final ValueNotifier<BookingTime> currentBookingTime =
      ValueNotifier(BookingTime.afternoon);

  set bookingTime(BookingTime newBookingTime) =>
      currentBookingTime.value = newBookingTime;

  final BookingTime bookingTime;
  final ValueNotifier<List<Booking>> _bookings;
  final ValueNotifier<Booking?> _activeBooking;

  final isTransactionInProgress = ValueNotifier(false);
  final Uuid uuid = const Uuid();

  ValueNotifier<Booking?> get activeBooking => _activeBooking;

  ValueNotifier<List<Booking>> get bookings => _bookings;

  bool get isBookingActive => _activeBooking.value != null;

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
      _activeBooking.value!.id,
      firstName ?? activeBooking.value!.firstName,
      lastName ?? activeBooking.value!.lastName,
      className ?? activeBooking.value!.className,
      seats ?? activeBooking.value!.seats,
      pricePaid ?? activeBooking.value!.pricePaid,
      priceType ?? activeBooking.value!.priceType,
      comments ?? activeBooking.value!.comments,
    );

    if (_activeBooking.value == newBooking) return;

    logger.debug("updated active booking");

    _activeBooking.value = newBooking;
  }

  List<Booking> getBookingsContainingSeat(Seat seat) {
    return _bookings.value
        .where((element) => element.seats.contains(seat))
        .toList();
  }

  void changeActiveBooking(Booking? newBooking) {
    if (isTransactionInProgress.value) {
      snackbar("Bitte warten bis die Transaktion abgeschlossen ist.");
      return;
    }
    logger.debug("changed active booking from id "
        "${_activeBooking.value?.id} to ${newBooking?.id}");
    if (isBookingActive) {
      _bookings.value.add(_activeBooking.value!);
    }
    _bookings.value.remove(newBooking);
    _activeBooking.value = newBooking;
    _bookings.notifyListeners();
  }

  void initializeActiveBooking(Seat firstSeat) {
    if (isTransactionInProgress.value) {
      snackbar("Bitte warten bis die Transaktion abgeschlossen ist.");
      return;
    }
    assert(activeBooking.value == null);
    logger.debug("initialize active booking");
    _activeBooking.value =
        Booking(uuid.v4(), "", "", "", {firstSeat}, 0, PriceType.normal, "");
  }
}
