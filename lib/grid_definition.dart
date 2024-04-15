import "package:collection/collection.dart";

class Rectangle {
  const Rectangle(this.width, this.height);

  final int width;
  final int height;
}

const List<Rectangle> bookingsDefinition = [
  Rectangle(28, 20),
  Rectangle(22, 1),
  Rectangle(23, 5),
  Rectangle(18, 1),
];

int get maxRowLength => bookingsDefinition.map((e) => e.width).max;
