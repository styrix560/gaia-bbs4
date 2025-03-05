import "package:flutter/material.dart";
import "package:supernova/supernova.dart";

import "../../utils.dart";
import "../api/api.dart";
import "booking.dart";
import "booking_time.dart";
import "price_type.dart";
import "seat.dart";

class GlobalData {
  factory GlobalData() {
    if (!globalDataInstances.containsKey(currentBookingTime.value)) {
      globalDataInstances[currentBookingTime.value] = GlobalData._internal(
        ValueNotifier([]),
        ValueNotifier(null),
      );
    }
    return globalDataInstances[currentBookingTime.value]!;
  }

  GlobalData._internal(
    this._bookings,
    this._activeBooking,
  ) {
    loadBookings();
  }

  static final Map<BookingTime, GlobalData> globalDataInstances = {};
  static final Map<BookingTime, List<Booking>> lastValues = {};
  static late final Api api;

  bool hasChanges() {
    for (final bookingTime in BookingTime.values) {
      if (!lastValues.containsKey(bookingTime)) {
        continue;
      }
      logger.debug("here");
      final current = globalDataInstances[bookingTime]!.bookings.value;
      final old = lastValues[bookingTime]!;
      if (current.length != old.length ||
          current.any((it) => !old.contains(it))) {
        return true;
      }
    }
    return false;
  }

  Future<void> pushBookings() async {
    isTransactionInProgress.value = true;
    try {
      await api.writeBookings(
        currentBookingTime.value.germanName,
        bookings.value,
      );
    } on Exception catch (error, stacktrace) {
      logger.error("error pushing changes to db", error, stacktrace);
      snackbar("Fehler beim Schreiben der Buchungen");
    }
    snackbar("Buchungen erfolgreich geschrieben");
    lastValues[currentBookingTime.value] = List.of(bookings.value);
    isDirty = false;
    isTransactionInProgress.value = false;
  }

  Future<void> loadBookings() async {
    isTransactionInProgress.value = true;
    late final List<Booking> newBookings;
    try {
      newBookings = await api.getBookings(currentBookingTime.value.germanName);
    } on Exception catch (error, stacktrace) {
      logger.error("error loading bookings", error, stacktrace);
      snackbar(
        "Fehler beim Laden der Buchungen. Ist Internet aktiviert und "
        "geht die Uhr richtig?",
      );
    }
    bookings.value = mergeBookings(
      bookings.value,
      newBookings,
      preferExternal: true,
    );
    GlobalData.lastValues[currentBookingTime.value] = List.of(bookings.value);
    isDirty = false;
    snackbar("Buchungen erfolgreich geladen");
    isTransactionInProgress.value = false;
  }

  static final ValueNotifier<BookingTime> currentBookingTime =
      ValueNotifier(BookingTime.afternoon);

  final ValueNotifier<List<Booking>> _bookings;
  final ValueNotifier<Booking?> _activeBooking;
  bool isDirty = false;

  final isTransactionInProgress = ValueNotifier(false);
  final Uuid uuid = const Uuid();

  ValueNotifier<Booking?> get activeBooking => _activeBooking;

  ValueNotifier<List<Booking>> get bookings => _bookings;

  bool get isBookingActive => _activeBooking.value != null;

  void updateActiveBooking({
    String? name,
    String? className,
    Set<Seat>? seats,
    int? pricePaid,
    PriceType? priceType,
    String? comments,
  }) {
    final newBooking = Booking(
      _activeBooking.value!.id,
      name ?? activeBooking.value!.name,
      className ?? activeBooking.value!.className,
      seats ?? activeBooking.value!.seats,
      pricePaid ?? activeBooking.value!.pricePaid,
      priceType ?? activeBooking.value!.priceType,
      comments ?? activeBooking.value!.comments,
    );

    if (_activeBooking.value == newBooking) return;

    logger.debug("updated active booking");

    _activeBooking.value = newBooking;
    isDirty = true;
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
    logger.debug("hasChanges", hasChanges());
  }

  void initializeActiveBooking(Seat firstSeat) {
    if (isTransactionInProgress.value) {
      snackbar("Bitte warten bis die Transaktion abgeschlossen ist.");
      return;
    }
    assert(activeBooking.value == null);
    logger.debug("initialize active booking");
    _activeBooking.value =
        Booking(uuid.v4(), "", "", {firstSeat}, 0, PriceType.normal, "");
  }

  /// Merges two Lists of [Booking]s together. [preferExternal] signifies,
  /// whether changes from the external source (i.e. the database) should
  /// override local changes. This is effectively the case, when pulling.
  /// Otherwise the local changes are more important.
  static List<Booking> mergeBookings(
    List<Booking> internal,
    List<Booking> external, {
    required bool preferExternal,
  }) {
    final keysToBookings = <String, Booking>{
      for (final booking in internal) booking.id: booking,
    };
    keysToBookings.addAll({
      for (final booking in external)
        if (preferExternal || !keysToBookings.containsKey(booking.id))
          booking.id: booking,
    });
    return keysToBookings.values.toList();
  }

  void deleteActiveBooking() {
    if (isTransactionInProgress.value) {
      snackbar("Bitte warten bis die Transaktion abgeschlossen ist.");
      return;
    }
    logger.debug("delete active booking with id "
        "${_activeBooking.value?.id}");
    _activeBooking.value = null;
    isDirty = true;
  }
}
