import "booking_time.dart";

enum PriceType {
  normal("Normal"),
  reduced("Reduziert"),
  free("Gratis");

  const PriceType(this.germanName);

  final String germanName;
}

extension PriceTypeExte on PriceType {
  int calculatePricePerSeat(BookingTime bookingTime) {
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
