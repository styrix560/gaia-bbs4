import "package:flutter/cupertino.dart";
import "package:supernova/supernova.dart" hide ValueChanged;

import "event_notifier.dart";
import "widgets/seat_cell.dart";

// TODO(styrix): split this file up into parts

class Booking {
  const Booking(
    this.id,
    this.firstName,
    this.lastName,
    this.className,
    this.seats,
    this.pricePaid,
    this.priceType,
  );

  final String id;
  final String firstName;
  final String lastName;
  final String className;
  final Set<Seat> seats;
  final int pricePaid;
  final PriceType priceType;

  // TODO(styrix): make isAfternoon enum
  int getPrice({required bool isAfternoon}) =>
      priceType.calculatePrice(isAfternoon: isAfternoon) * seats.length;

  List<Seat> getSeatsSorted() => IterableExtension(seats).sortedBy(
        (element) => element.toString(),
      );

  Booking update({
    String? firstName,
    String? lastName,
    String? className,
    int? pricePaid,
    PriceType? priceType,
  }) {
    return Booking(
      id,
      firstName ?? this.firstName,
      lastName ?? this.lastName,
      className ?? this.className,
      seats,
      pricePaid ?? this.pricePaid,
      priceType ?? this.priceType,
    );
  }

  // TODO(styrix): make this an extension on seatCells
  void updateSeats(
    Map<Seat, SeatCellWidget> seatCells, {
    bool? isActive,
    bool? resetBooking,
  }) {
    assert(
      isActive != null || (resetBooking ?? false),
      "If isActive is not supplied, resetBooking has to be true",
    );
    for (final seat in seats) {
      seat.update(
        seatCells,
        resetBooking ?? false ? null : this,
        isActive: isActive ?? false,
      );
    }
  }
}

enum PriceType {
  normal("Normal"),
  reduced("Reduziert"),
  free("Gratis");

  const PriceType(this.name);

  final String name;
}

extension PriceTypeExte on PriceType {
  int calculatePrice({required bool isAfternoon}) {
    if (this == PriceType.free) return 0;
    if (isAfternoon) {
      if (this == PriceType.normal) return 15;
      return 10;
    }
    if (this == PriceType.normal) return 20;
    return 15;
  }
}

@immutable
class Seat {
  const Seat(this.row, this.seat);

  final int row;
  final int seat;

  @override
  String toString() {
    return "R${row + 1} P${seat + 1}";
  }

  // TODO(styrix): make this an extension on seatCells

  // TODO(styrix): maybe make this a higher level function by mirroring the
  // TODO(styrix): syntax of updateSeats
  void update(
    Map<Seat, SeatCellWidget> seatCells,
    Booking? activeBooking, {
    required bool isActive,
  }) {
    seatCells[this] =
        // ignore: avoid-collection-methods-with-unrelated-types
        seatCells[this]!.updateWithValues(
      activeBooking,
      isActive: isActive,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Seat && row == other.row && seat == other.seat;
  }

  @override
  int get hashCode => Object.hash(seat, row);
}

extension SeatExt on Seat {
  Seat fromString(String string) {
    final split = string.split(" ");
    // ignore: prefer-first
    final row = int.parse(split[0].substring(1)) - 1;
    final seat = int.parse(split[1].substring(1)) - 1;
    return Seat(row, seat);
  }
}

// TODO(styrix): sort methods
class GlobalData {
  factory GlobalData() {
    return _singleton;
  }

  GlobalData._internal(this._bookings, this._activeBooking);

  static final GlobalData _singleton = GlobalData._internal(
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
  final Uuid uuid = const Uuid();

  final _eventNotifiers = (
    activeBooking: EventNotifier<ActiveBookingEventArgs>(),
    bookings: EventNotifier<BookingsEventArgs>(),
  );

  List<Booking> _bookings;
  Booking? _activeBooking;

  Booking? get activeBooking => _activeBooking;

  List<Booking> get bookings => _bookings;

  VoidCallback activeBookingListen<E extends ActiveBookingEventArgs>(
    ValueChanged<E> listener,
  ) =>
      _eventNotifiers.activeBooking.addListener<E>(listener);

  VoidCallback bookingsListen<E extends BookingsEventArgs>(
    ValueChanged<E> listener,
  ) =>
      _eventNotifiers.bookings.addListener<E>(listener);

  List<Booking> findClickedBookings(Seat clickedSeat) => _bookings
      .where((element) => element.seats.contains(clickedSeat))
      .toList();

  bool isBookingActive() => _activeBooking != null;

  void deactivateBooking() {
    _eventNotifiers.activeBooking
        .notifyListeners(ActiveBookingEventArgs.deactivated(_activeBooking!));
    _bookings.add(_activeBooking!);
    _activeBooking = null;
  }

  void updateActiveBooking({
    String? firstName,
    String? lastName,
    String? className,
    int? pricePaid,
    PriceType? priceType,
  }) {
    final newBooking = _activeBooking!.update(
      firstName: firstName,
      lastName: lastName,
      className: className,
      pricePaid: pricePaid,
      priceType: priceType,
    );
    if (newBooking == _activeBooking) return;
    _activeBooking = newBooking;
    _eventNotifiers.activeBooking
        .notifyListeners(ActiveBookingEventArgs.updated(
      firstName: firstName,
      lastName: lastName,
      className: className,
      pricePaid: pricePaid,
      priceType: priceType,
    ));
  }

  void activateBooking(Booking newBooking) {
    _bookings.remove(newBooking);
    _activeBooking = newBooking;
    _eventNotifiers.activeBooking
        .notifyListeners(ActiveBookingEventArgs.activated(newBooking));
  }

  void changeActiveBooking(Booking newBooking) {
    if (_activeBooking != null) {
      deactivateBooking();
    }

    activateBooking(newBooking);
  }

  void updateActiveBookingSeats(Seat seat) {
    if (_activeBooking!.seats.contains(seat)) {
      if (_activeBooking!.seats.length == 1) {
        _eventNotifiers.activeBooking.notifyListeners(
          ActiveBookingEventArgs.deleted(_activeBooking!),
        );
        _activeBooking = null;
        return;
      }
      _activeBooking!.seats.remove(seat);
      _eventNotifiers.activeBooking.notifyListeners(
        ActiveBookingEventArgs.seatRemoved(seat),
      );
    } else {
      _activeBooking!.seats.add(seat);
      _eventNotifiers.activeBooking.notifyListeners(
        ActiveBookingEventArgs.seatAdded(seat),
      );
    }
  }

  void initActiveBooking(Seat seat) {
    _activeBooking =
        Booking(uuid.v4(), "", "", "", {seat}, 0, PriceType.normal);
    _eventNotifiers.activeBooking
        .notifyListeners(ActiveBookingEventArgs.created(_activeBooking!));
  }
}
