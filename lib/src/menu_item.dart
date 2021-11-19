import 'package:demoflu/src/example_builder.dart';
import 'package:flutter/material.dart';

/// Represents a menu item in the app menu.
class MenuItem {
  /// Buils a [MenuItem].
  MenuItem(
      {required this.name,
      this.builder,
      this.resizable,
      this.codeFile,
      this.maxSize,
      this.consoleEnabled,
      this.italic = false,
      this.indentation = 1});

  final String name;
  final ExampleBuilder? builder;
  final String? codeFile;
  final bool? resizable;
  final Size? maxSize;
  final bool? consoleEnabled;
  final bool italic;
  final int indentation;
}
