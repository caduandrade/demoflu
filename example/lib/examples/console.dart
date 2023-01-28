import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';

class ConsoleExample extends Example {
  ConsoleExample()
      : super(
            widget: MainWidget(),
            codeFile: 'lib/examples/console.dart',
            consoleEnabled: true);
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            onPressed: () {
              DemoFlu.printOnConsole(context, 'Hi!');
            },
            child: Text('Print')));
  }
}
