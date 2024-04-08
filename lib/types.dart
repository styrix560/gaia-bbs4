import 'package:flutter/material.dart';

class Booking {
  String id;
  String firstName;
  String lastName;
  String className;
  List<Seat> seats;
  int price;
  int paidAmount;
  PriceType priceType;

  Booking(bool isAfternoon, this.id, this.firstName, this.lastName,
      this.className, this.seats, this.paidAmount, this.priceType)
      : price = priceType.calculatePrice(isAfternoon) * seats.length;
}

enum PriceType {
  Normal("Normal"),
  Reduced("Reduziert"),
  Free("Gratis");

  final String name;

  const PriceType(this.name);
}

extension PriceTypeExte on PriceType {
  int calculatePrice(bool isAfternoon) {
    if (this == PriceType.Free) return 0;
    if (isAfternoon) {
      if (this == PriceType.Normal) return 15;
      return 10;
    }
    if (this == PriceType.Normal) return 20;
    return 15;
  }
}

class Seat {
  late int row;
  late int seat;

  Seat(this.row, this.seat);

  String toString() {
    return "R${row + 1} P${seat + 1}";
  }

  @override
  bool operator ==(Object other) {
    return other is Seat && row == other.row && seat == other.seat;
  }

  Seat.fromString(String s) {
    var split = s.split(" ");
    row = int.parse(split[0].substring(1, split[0].length)) - 1;
    seat = int.parse(split[1].substring(1, split[1].length)) - 1;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => row * 100 + seat;
}
