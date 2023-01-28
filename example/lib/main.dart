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
  runApp(DemoFluApp(title: 'Demoflu(1.0.0) Demo', menuItems: _menuItems()));
}

List<DemoMenuItem> _menuItems() {
  var builder = DemoMenuItem.builder();
  builder
    ..indent(1)
    ..add('Section')
    ..indent(2)
    ..add('Stateless', example: StatelessExample())
    ..add('Stateful', example: StatefulExample())
    ..add('Console', example: ConsoleExample())
    ..add('Bar addon', example: BarAddonExample())
    ..add('Not resizable', example: NotResizableExample())
    ..add('Ignore marked code', example: IgnoreExample())
    ..add('Nested sections')
    ..indent(3)
    ..add('Section with example', example: RandomWidgetExample())
    ..indent(4)
    ..add('Leaf 1', example: RandomWidgetExample())
    ..add('Leaf 2', example: RandomWidgetExample())
    ..indent(3)
    ..add('Section with example', example: RandomWidgetExample())
    ..indent(4)
    ..add('Leaf 3', example: RandomWidgetExample())
    ..add('Leaf 4', example: RandomWidgetExample());
  return builder.menuItems;
}
