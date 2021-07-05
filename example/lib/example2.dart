import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Example2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            onPressed: () {
              DemoFlu.printOnConsole(context, 'Hi!');
            },
            child: Text('Example 2')));
  }
}
