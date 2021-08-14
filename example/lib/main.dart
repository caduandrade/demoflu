import 'package:demoflu/demoflu.dart';
import 'package:example/example1.dart';
import 'package:example/example2.dart';
import 'package:example/example3.dart';
import 'package:example/example4.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DemoFluApp(initialHeightWeight: .5, title: 'Example Demo', sections: [
    Section(name: 'Section', examples: [
      Example(
        name: 'Example 1',
        builder: (notifier) => Example1(),
        codeFile: 'lib/example1.dart',
      ),
      Example(
          name: 'Example 2',
          builder: (notifier) => Example2(),
          codeFile: 'lib/example2.dart',
          consoleEnabled: true,
          resizable: true),
      Example(name: 'Example 3', builder: (notifier) => Example3()),
      Example(
          name: 'Example 4',
          builder: (notifier) => Example4(notifier),
          buttons: ['Button 1', 'Button 2'])
    ])
  ]));
}
