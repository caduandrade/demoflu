import 'package:flutter/material.dart';

class ConsoleExample extends StatelessWidget {
  const ConsoleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
                onPressed: () {
                  print('Hi!');
                },
                child: const Text('Print'))));
  }
}
