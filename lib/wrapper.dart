import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  String title;
  Widget child;

  Wrapper(this.title, this.child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontSize: 15),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
