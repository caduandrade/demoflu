import 'package:demoflu/demoflu.dart';
import 'package:demoflu_example/examples/bar_addon.dart';
import 'package:demoflu_example/examples/not_resizable.dart';
import 'package:demoflu_example/examples/stateless.dart';
import 'package:demoflu_example/examples/console.dart';
import 'package:demoflu_example/examples/stateful.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DemoFluApp(heightWeight: .5, title: 'Example Demo', menuItems: [
    DemoMenuItem(name: 'Section', italic: true),
    DemoMenuItem(name: 'Stateless', example: Stateless(), indentation: 2),
    DemoMenuItem(name: 'Stateful', example: StatefulExample(), indentation: 2),
    DemoMenuItem(name: 'Console', example: Console(), indentation: 2),
    DemoMenuItem(name: 'Bar addon', example: BarAddonExample(), indentation: 2),
    DemoMenuItem(name: 'Not resizable', example: NotResizable(), indentation: 2)
  ]));
}
