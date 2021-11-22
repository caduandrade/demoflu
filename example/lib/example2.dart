import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Example2 extends Example {
  @override
  Widget buildMainWidget(BuildContext context) {
    return MainWidget();
  }
}

class MainWidget extends StatelessWidget {
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
