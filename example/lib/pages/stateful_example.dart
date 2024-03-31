import 'package:flutter/material.dart';

class StatefulExample extends StatefulWidget {
  const StatefulExample({super.key});

  @override
  State<StatefulWidget> createState() => StatefulExampleState();
}

class StatefulExampleState extends State<StatefulExample> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow[100],
        child: Center(
            child: Padding(
                padding: const EdgeInsets.all(32),
                child: TextButton(
                    onPressed: _onPressed, child: Text('Tap here: $_count')))));
  }

  void _onPressed() {
    setState(() {
      _count++;
    });
  }
}
