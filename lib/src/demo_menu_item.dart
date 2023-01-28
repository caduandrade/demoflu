import 'dart:math' as math;

import 'package:demoflu/src/example.dart';

/// Represents a menu item in the app menu.
class DemoMenuItem {
  DemoMenuItem({required this.name, this.example, int indent = 1})
      : _indent = math.max(indent, 1);

  final String name;

  final AbstractExample? example;

  final int _indent;

  int get indent => _indent;
}
