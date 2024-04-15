import "package:flutter/material.dart";

// TODO(styrix): remove the wrapper class
class Wrapper extends StatelessWidget {
  const Wrapper(this.title, this.child, {super.key});

  final String title;
  final Widget child;

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
