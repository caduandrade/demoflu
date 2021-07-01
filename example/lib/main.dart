import 'package:demoflu/demoflu.dart';
import 'package:example/example1.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DemoFluApp(title: 'Example Demo', sections: [
    DFSection(name: 'Teste', examples: [
      DFExample(
        name: 'Example 1',
        builder: (context) => Example1(),
        resizable: true,
        maxSize: Size(600, 450),
        codeFile: 'lib/example1.dart',
      ),
      DFExample(
          name: 'Menu 2', builder: (context) => Center(child: Text('Text 2')))
    ])
  ]));
}
