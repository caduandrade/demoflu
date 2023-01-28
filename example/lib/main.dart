import 'package:demoflu/demoflu.dart';
import 'package:example/examples/bar_addon.dart';
import 'package:example/examples/console.dart';
import 'package:example/examples/ignore.dart';
import 'package:example/examples/not_resizable.dart';
import 'package:example/examples/random.dart';
import 'package:example/examples/stateful.dart';
import 'package:example/examples/stateless.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DemoFluApp(title: 'Demoflu(1.0.0) Demo', menuItems: [
    DemoMenuItem(name: 'Section'),
    DemoMenuItem(name: 'Stateless', example: StatelessExample(), indent: 2),
    DemoMenuItem(name: 'Stateful', example: StatefulExample(), indent: 2),
    DemoMenuItem(name: 'Console', example: ConsoleExample(), indent: 2),
    DemoMenuItem(name: 'Bar addon', example: BarAddonExample(), indent: 2),
    DemoMenuItem(
        name: 'Not resizable', example: NotResizableExample(), indent: 2),
    DemoMenuItem(
        name: 'Ignore marked code', example: IgnoreExample(), indent: 2),
    DemoMenuItem(name: 'Nested sections'),
    DemoMenuItem(
        name: 'Section with example',
        example: RandomWidgetExample(),
        indent: 2),
    DemoMenuItem(name: 'Leaf 1', example: RandomWidgetExample(), indent: 3),
    DemoMenuItem(name: 'Leaf 2', example: RandomWidgetExample(), indent: 3),
    DemoMenuItem(
        name: 'Section with example',
        example: RandomWidgetExample(),
        indent: 2),
    DemoMenuItem(name: 'Leaf 3', example: RandomWidgetExample(), indent: 3),
    DemoMenuItem(name: 'Leaf 4', example: RandomWidgetExample(), indent: 3)
  ]));
}
