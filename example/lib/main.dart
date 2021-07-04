import 'package:demoflu/demoflu.dart';
import 'package:example/example1.dart';
import 'package:example/example2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DemoFluApp(title: 'Example Demo', sections: [
    DFSection(name: 'Section', examples: [
      DFExample(
        name: 'Example 1',
        builder: (context) => Example1(),
        resizable: true,
        maxSize: Size(600, 450),
        codeFile: 'lib/example1.dart',
      ),
      DFExample(
          resizable: true,
          name: 'Example 2',
          builder: (context) => Example2(),
          codeFile: 'lib/example2.dart',
          consoleEnabled: true)
    ])
  ]));
}
