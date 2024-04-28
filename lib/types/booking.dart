import "package:supernova/supernova.dart" hide ValueChanged;

import "booking_time.dart";
import "price_type.dart";
import "seat.dart";

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
}
