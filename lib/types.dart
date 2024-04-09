import 'package:collection/collection.dart';

class Booking {
  final String id;
  final String firstName;
  final String lastName;
  final String className;
  final Set<Seat> seats;
  final int paidAmount;
  final PriceType priceType;

  int getPrice(isAfternoon) =>
      priceType.calculatePrice(isAfternoon) * seats.length;

  List<Seat> getSeatsSorted() => seats.toList().sorted(
        (a, b) => a.toString().compareTo(b.toString()),
      );

  const Booking(this.id, this.firstName, this.lastName, this.className,
      this.seats, this.paidAmount, this.priceType);
}

enum PriceType {
  normal("Normal"),
  reduced("Reduziert"),
  free("Gratis");

  final String name;

  const PriceType(this.name);
}

extension PriceTypeExte on PriceType {
  int calculatePrice(bool isAfternoon) {
    if (this == PriceType.free) return 0;
    if (isAfternoon) {
      if (this == PriceType.normal) return 15;
      return 10;
    }
    if (this == PriceType.normal) return 20;
    return 15;
  }
}

class Seat {
  final int row;
  final int seat;

  const Seat(this.row, this.seat);

  @override
  String toString() {
    return "R${row + 1} P${seat + 1}";
  }

  @override
  bool operator ==(Object other) {
    return other is Seat && row == other.row && seat == other.seat;
  }

  @override
  int get hashCode => row * 100 + seat;
}

extension SeatExt on Seat {
  Seat fromString(String string) {
    var split = string.split(" ");
    var row = int.parse(split[0].substring(1, split[0].length)) - 1;
    var seat = int.parse(split[1].substring(1, split[1].length)) - 1;
    return Seat(row, seat);
  }
}
