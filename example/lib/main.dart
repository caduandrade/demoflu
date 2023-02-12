import 'package:demoflu/demoflu.dart';
import 'package:example/examples/bar_addon.dart';
import 'package:example/examples/console.dart';
import 'package:example/examples/ignore.dart';
import 'package:example/examples/not_resizable.dart';
import 'package:example/examples/stateful.dart';
import 'package:example/examples/stateless.dart';
import 'package:example/examples/text.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DemoFluApp(title: 'DemoFlu (1.2.1)', rootMenus: [
    _stateless,
    _stateful,
    _console,
    _barAddon,
    _notResizable,
    _ignoreMarkedCode,
    _nestedSection
  ]));
}

DemoMenuItem get _stateless =>
    DemoMenuItem('Stateless', example: StatelessExample());

DemoMenuItem get _stateful =>
    DemoMenuItem('Stateful', example: StatefulExample());

DemoMenuItem get _console => DemoMenuItem('Console', example: ConsoleExample());

DemoMenuItem get _barAddon =>
    DemoMenuItem('Bar addon', example: BarAddonExample());

DemoMenuItem get _notResizable =>
    DemoMenuItem('Not resizable', example: NotResizableExample());

DemoMenuItem get _ignoreMarkedCode =>
    DemoMenuItem('Ignore marked code', example: IgnoreExample());

DemoMenuItem get _nestedSection => DemoMenuItem('Nested sections')
  ..add(_section1WithExample)
  ..add(_section2WithExample);

DemoMenuItem get _section1WithExample =>
    DemoMenuItem('Section 1', example: TextWidgetExample('Section 1'))
      ..add(_leaf1a)
      ..add(_leaf1b);

DemoMenuItem get _leaf1a =>
    DemoMenuItem('Leaf 1a', example: TextWidgetExample('Leaf 1a'));

DemoMenuItem get _leaf1b =>
    DemoMenuItem('Leaf 1b', example: TextWidgetExample('Leaf 1b'));

DemoMenuItem get _section2WithExample =>
    DemoMenuItem('Section 2', example: TextWidgetExample('Section 2'))
      ..add(_leaf2a)
      ..add(_leaf2b);

DemoMenuItem get _leaf2a =>
    DemoMenuItem('Leaf 2a', example: TextWidgetExample('Leaf 2a'));

DemoMenuItem get _leaf2b =>
    DemoMenuItem('Leaf 2b', example: TextWidgetExample('Leaf 2b'));
