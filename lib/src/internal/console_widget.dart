import 'package:demoflu/src/internal/console_controller.dart';
import 'package:flutter/material.dart';

class ConsoleWidget extends StatelessWidget {
  ConsoleWidget({required this.console});

  final ConsoleController console;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: console,
        builder: (context, child) {
          return Container(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: _itemBuilder,
                  itemCount: console.values.length),
              color: Colors.white);
        });
  }

  Widget? _itemBuilder(BuildContext context, int index) {
    return Text(console.values[index]);
  }
}
