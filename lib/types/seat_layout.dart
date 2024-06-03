import "package:supernova/supernova.dart";

class Rectangle {
  const Rectangle(this.width, this.height);

  final int width;
  final int height;
}

final Map<String, List<int>> seatLayout = {
  "Parkett": [for (var i = 0; i < 19; i++) 28, 23],
  "Sparkassenrang": [
    for (var i = 0; i < 5; i++) 23,
    18,
  ],
};

int get maxRowLength => seatLayout.values.map((group) => group.max).max;
