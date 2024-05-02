import "package:flutter/material.dart";

@immutable
class Seat {
  const Seat(this.row, this.seat);

  final int row;
  final int seat;

  @override
  String toString() {
    return "R${row + 1} P${seat + 1}";
  }

  static Seat fromString(String string) {
    final split = string.split(" ");
    // ignore: prefer-first
    final row = int.parse(split[0].substring(1)) - 1;
    final seat = int.parse(split[1].substring(1)) - 1;
    return Seat(row, seat);
  }

  @override
  bool operator ==(Object other) {
    return other is Seat && row == other.row && seat == other.seat;
  }

  @override
  int get hashCode => Object.hash(seat, row);
}

extension SeatExt on Seat {}
