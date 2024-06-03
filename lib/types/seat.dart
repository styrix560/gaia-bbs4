import "package:flutter/material.dart";
import "package:supernova/supernova.dart";

import "seat_layout.dart";

@immutable
class Seat {
  const Seat(this.row, this.seat, this.groupName);

  factory Seat.fromString(String string) {
    final split = string.split(" ");
    // ignore: prefer-first
    final row = int.parse(split[0].substring(1));
    final seat = int.parse(split[1].substring(1));
    var rowCounter = 0;
    var name = "";
    for (final entry in seatLayout.entries) {
      rowCounter += entry.value.length;
      if (rowCounter >= row) {
        name = entry.key;
        rowCounter -= entry.value.length;
        break;
      }
    }
    return Seat(row - rowCounter - 1, seat - 1, name);
  }

  final int row;
  final int seat;
  final String groupName;

  @override
  String toString() {
    return "R${row + 1} P${seat + 1}";
  }

  String toDatabaseString() {
    var globalRow = 0;
    for (final entry in seatLayout.entries) {
      if (entry.key == groupName) {
        break;
      }
      globalRow += entry.value.length;
    }
    return "R${row + globalRow + 1} P${seat + 1}";
  }

  @override
  bool operator ==(Object other) {
    return other is Seat &&
        groupName == other.groupName &&
        row == other.row &&
        seat == other.seat;
  }

  @override
  int get hashCode => Object.hash(seat, row);
}
