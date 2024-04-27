import "package:flutter/material.dart";

extension BuildExt on BuildContext {
  Future<void> gotoNoback(Widget widget) async => Navigator.of(this)
      .pushReplacement(MaterialPageRoute<void>(builder: (_) => widget));
}

Widget space({double width = 0, double height = 8}) =>
    SizedBox(width: width, height: height);
