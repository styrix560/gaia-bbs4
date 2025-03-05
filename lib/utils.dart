import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "main.dart";

extension BuildExt on BuildContext {
  Future<void> gotoNoback(Widget widget) async => Navigator.of(this)
      .pushReplacement(MaterialPageRoute<void>(builder: (_) => widget));

  Future<void> goto(Widget widget) async =>
      Navigator.of(this).push(MaterialPageRoute<void>(builder: (_) => widget));

  Future<void> pop(dynamic args) async => Navigator.of(this).pop(args);
}

void snackbar([String msg = "Dieses Feature funktioniert noch nicht ganz."]) =>
    scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(msg)));

Widget space({double width = 0, double height = 8}) =>
    SizedBox(width: width, height: height);

VoidCallback useRebuild() {
  final rebuildCounter = useState(0);
  return () => rebuildCounter.value++;
}
