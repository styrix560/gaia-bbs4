import "package:collection/collection.dart";

import "package:flutter/cupertino.dart";

class Rectangle {
  final int width;
  final int height;

  const Rectangle(this.width, this.height);
}

const List<Rectangle> bookingsDefinition = [
  Rectangle(28, 20),
  Rectangle(22, 1),
  Rectangle(23, 5),
  Rectangle(18, 1),
];

int maxRowLength = bookingsDefinition.map((e) => e.width).max;
