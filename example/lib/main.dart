import 'package:demoflu/demoflu.dart';
import 'package:demoflu_example/example1.dart';
import 'package:demoflu_example/example2.dart';
import 'package:demoflu_example/example3.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DemoFluApp(
      initialHeightWeight: .5,
      title: 'Example Demo',
      appMenuBuilder: () {
        return [
          DemoMenuItem(name: 'Section', italic: true),
          DemoMenuItem(
              name: 'Example 1',
              builder: () => Example1(),
              codeFile: 'lib/example1.dart',
              resizable: true,
              indentation: 2),
          DemoMenuItem(
              name: 'Example 2',
              builder: () => Example2(),
              codeFile: 'lib/example2.dart',
              consoleEnabled: true,
              indentation: 2),
          DemoMenuItem(
              name: 'Example 3',
              builder: () => Example3(),
              codeFile: 'lib/example3.dart',
              resizable: true,
              indentation: 2)
        ];
      }));
}
