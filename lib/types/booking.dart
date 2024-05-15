import "package:supernova/supernova.dart" hide ValueChanged;

import "booking_time.dart";
import "price_type.dart";
import "seat.dart";

@immutable
class Booking {
  const Booking(
    this.id,
    this.firstName,
    this.lastName,
    this.className,
    this.seats,
    this.pricePaid,
    this.priceType,
    this.comments,
  );

  final String id;
  final String firstName;
  final String lastName;
  final String className;
  final Set<Seat> seats;
  final int pricePaid;
  final PriceType priceType;
  final String comments;

  Booking copy() => Booking(
        id,
        firstName,
        lastName,
        className,
        Set.of(seats),
        pricePaid,
        priceType,
        comments,
      );

  int getPrice({required BookingTime bookingTime}) =>
      priceType.calculatePrice(bookingTime) * seats.length;

  List<Seat> getSeatsSorted() => IterableExtension(seats).sorted(
        (a, b) {
          if (a.row == b.row) {
            return a.seat.compareTo(b.seat);
          }
          return a.row.compareTo(b.row);
        },
      );

  bool matches(String query) =>
      firstName.toLowerCase().contains(query.toLowerCase()) ||
      lastName.toLowerCase().contains(query.toLowerCase()) ||
      className.toLowerCase().contains(query.toLowerCase());

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Booking &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            firstName == other.firstName &&
            lastName == other.lastName &&
            className == other.className &&
            const SetEquality<Seat>().equals(seats, other.seats) &&
            pricePaid == other.pricePaid &&
            priceType == other.priceType &&
            comments == other.comments;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      className.hashCode ^
      seats.hashCode ^
      pricePaid.hashCode ^
      priceType.hashCode ^
      comments.hashCode;

  @override
  String toString() {
    return "Booking($id, $lastName, $firstName, (${seats.join(" / ")}), "
        "$pricePaid, $priceType, $comments)";
  }
}
