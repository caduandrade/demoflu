import 'package:flutter/material.dart';

class NotResizableExample extends StatelessWidget {
  const NotResizableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green[200],
        child: const Center(child: Text('Not resizable')));
  }
}
