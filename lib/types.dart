import "package:flutter/cupertino.dart";
import "package:supernova/supernova.dart" hide ValueChanged;

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
// TODO(styrix): make this its own file
class GlobalData extends ChangeNotifier {
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
