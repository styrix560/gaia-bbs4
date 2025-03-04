import "package:supernova/supernova.dart" hide ValueChanged;

import "booking_time.dart";
import "price_type.dart";
import "seat.dart";

@immutable
class Booking {
  const Booking(
    this.id,
    this.name,
    this.className,
    this.seats,
    this.pricePaid,
    this.priceType,
    this.comments,
  );

  final String id;
  final String name;
  final String className;
  final Set<Seat> seats;
  final int pricePaid;
  final PriceType priceType;
  final String comments;

  Booking copy({
    String? id,
    String? name,
    String? className,
    Set<Seat>? seats,
    int? pricePaid,
    PriceType? priceType,
    String? comments,
  }) =>
      Booking(
        id ?? this.id,
        name ?? this.name,
        className ?? this.className,
        seats ?? Set.of(this.seats),
        pricePaid ?? this.pricePaid,
        priceType ?? this.priceType,
        comments ?? this.comments,
      );

  int getPrice({required BookingTime bookingTime}) =>
      priceType.calculatePricePerSeat(bookingTime) * seats.length;

  List<Seat> getSeatsSorted() => IterableExtension(seats).sorted(
        (a, b) {
          if (a.row == b.row) {
            return a.seat.compareTo(b.seat);
          }
          return a.row.compareTo(b.row);
        },
      );

  Map<String, List<Seat>> getSeatsByGroup() {
    final groups = <String, List<Seat>>{};
    for (final seat in seats) {
      if (groups.containsKey(seat.groupName)) {
        groups[seat.groupName]!.add(seat);
      } else {
        groups[seat.groupName] = [seat];
      }
    }
    return groups;
  }

  bool matches(String query) =>
      name.toLowerCase().contains(query.toLowerCase()) ||
      className.toLowerCase().contains(query.toLowerCase());

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Booking &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            name == other.name &&
            className == other.className &&
            const SetEquality<Seat>().equals(seats, other.seats) &&
            pricePaid == other.pricePaid &&
            priceType == other.priceType &&
            comments == other.comments;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      className.hashCode ^
      seats.hashCode ^
      pricePaid.hashCode ^
      priceType.hashCode ^
      comments.hashCode;

  @override
  String toString() {
    return "Booking($id, $name, (${seats.join(" / ")}), "
        "$pricePaid, $priceType, $comments)";
  }
}
