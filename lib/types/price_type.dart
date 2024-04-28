import "booking_time.dart";

enum PriceType {
  normal("Normal"),
  reduced("Reduziert"),
  free("Gratis");

  const PriceType(this.name);

  final String name;
}

extension PriceTypeExte on PriceType {
  int calculatePrice(BookingTime bookingTime) {
    if (this == PriceType.free) return 0;
    switch (bookingTime) {
      case BookingTime.afternoon:
        if (this == PriceType.normal) {
          return 15;
        } else {
          return 10;
        }
      case BookingTime.evening:
        if (this == PriceType.normal) {
          return 20;
        } else {
          return 15;
        }
    }
  }
}
