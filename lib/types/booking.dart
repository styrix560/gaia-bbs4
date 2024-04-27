import "package:supernova/supernova.dart" hide ValueChanged;

import "price_type.dart";
import "seat.dart";

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

  List<Seat> getSeatsSorted() => IterableExtension(seats).sorted(
        (a, b) {
          if (a.row == b.row) {
            return a.seat.compareTo(b.seat);
          }
          return a.row.compareTo(b.row);
        },
      );
}
