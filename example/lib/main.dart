import 'package:demoflu/demoflu.dart';
import 'package:demoflu_example/example1.dart';
import 'package:demoflu_example/example2.dart';
import 'package:demoflu_example/example3.dart';
import 'package:demoflu_example/example4.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DemoFluApp(
      initialHeightWeight: .5,
      title: 'Example Demo',
      appMenuBuilder: (exampleMenuNotifier) {
        return [
          MenuItem(name: 'Section', italic: true),
          MenuItem(
              name: 'Example 1',
              example: Example1(),
              codeFile: 'lib/example1.dart',
              indentation: 2),
          MenuItem(
              name: 'Example 2',
              example: Example2(),
              codeFile: 'lib/example2.dart',
              consoleEnabled: true,
              resizable: true,
              indentation: 2),
          MenuItem(name: 'Example 3', example: Example3(), indentation: 2),
          MenuItem(
              name: 'Example 4',
              example: Example4(exampleMenuNotifier),
              indentation: 2)
        ];
      }));
}
