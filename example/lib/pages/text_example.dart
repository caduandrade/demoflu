import 'package:flutter/material.dart';

class TextExample extends StatelessWidget {
  const TextExample({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green[100],
        child: Center(
            child:
                Padding(padding: const EdgeInsets.all(32), child: Text(name))));
  }
}
