import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  final String title;
  final Widget child;

  const Wrapper(this.title, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(child: child),
      ),
    );
  }
}
