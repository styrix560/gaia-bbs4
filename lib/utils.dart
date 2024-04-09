import 'package:flutter/material.dart';

extension BuildExt on BuildContext {
  gotoNoback(Widget widget) => Navigator.of(this)
      .pushReplacement(MaterialPageRoute(builder: (_) => widget));

  Widget space([double width = 0, double height = 9]) =>
      SizedBox(width: width, height: height);
}
