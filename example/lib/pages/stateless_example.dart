import 'package:flutter/material.dart';

class StatelessExample extends StatelessWidget {
  const StatelessExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue[100],
        child: const Center(
            child: Padding(
                padding: EdgeInsets.all(32), child: Text('Stateless'))));
  }
}
