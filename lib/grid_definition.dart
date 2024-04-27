class Rectangle {
  const Rectangle(this.width, this.height);

  final int width;
  final int height;
}

final List<int> rowWidths = [
  for (var i = 0; i < 20; i++) 28,
  22,
  for (var i = 0; i < 5; i++) 23,
  18,
];
