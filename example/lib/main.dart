import 'package:demoflu/demoflu.dart';
import 'package:example/example1.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DemoFluApp(title: 'Example Demo', menuSections: [
    DemoFluMenuSection(menuItems: [
      DemoFluMenuItem(
        text: 'Example 1',
        builder: (context) => Example1(),
        resizableContent: true,
        limitedSize: Size(600, 450),
        codeFile: 'lib/example1.dart',
      ),
      DemoFluMenuItem(
          text: 'Menu 2', builder: (context) => Center(child: Text('Text 2')))
    ])
  ]));
}
