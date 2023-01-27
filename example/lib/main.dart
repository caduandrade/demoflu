import 'package:demoflu/demoflu.dart';
import 'package:demoflu_example/example1/example1.dart';
import 'package:demoflu_example/example2/example2.dart';
import 'package:demoflu_example/example3/example3.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DemoFluApp(initialHeightWeight: .5, title: 'Example Demo', menuItems: [
    DemoMenuItem(name: 'Section', italic: true),
    DemoMenuItem(name: 'Example 1', example: Example1(), indentation: 2),
    DemoMenuItem(name: 'Example 2', example: Example2(), indentation: 2),
    DemoMenuItem(name: 'Example 3', example: Example3(), indentation: 2)
  ]));
}
