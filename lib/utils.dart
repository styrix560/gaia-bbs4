import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

extension BuildExt on BuildContext {
  Future<void> gotoNoback(Widget widget) async => Navigator.of(this)
      .pushReplacement(MaterialPageRoute<void>(builder: (_) => widget));
}

Widget space({double width = 0, double height = 8}) =>
    SizedBox(width: width, height: height);

VoidCallback useRebuild() {
  final rebuildCounter = useState(0);
  return () => rebuildCounter.value++;
}
