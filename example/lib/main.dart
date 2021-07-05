import 'package:demoflu/demoflu.dart';
import 'package:example/example1.dart';
import 'package:example/example2.dart';
import 'package:example/example3.dart';
import 'package:example/example4.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DemoFluApp(title: 'Example Demo', sections: [
    Section(name: 'Section', examples: [
      Example(
        name: 'Example 1',
        builder: (buttonClickNotifier) => Example1(),
        codeFile: 'lib/example1.dart',
      ),
      Example(
          name: 'Example 2',
          builder: (buttonClickNotifier) => Example2(),
          codeFile: 'lib/example2.dart',
          consoleEnabled: true,
          resizable: true),
      Example(name: 'Example 3', builder: (buttonClickNotifier) => Example3()),
      Example(
          name: 'Example 4',
          builder: (buttonClickNotifier) => Example4(buttonClickNotifier),
          buttons: ['Button 1', 'Button 2'])
    ])
  ]));
}
