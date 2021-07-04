import 'package:flutter/material.dart';

/// Represents a menu item for a widget example.
class DFExample {
  /// Buils a [DFExample].
  const DFExample(
      {required this.name,
      required this.builder,
      this.resizable = false,
      this.codeFile,
      this.maxSize,
      this.consoleEnabled});

  final String name;
  final WidgetBuilder builder;
  final String? codeFile;
  final bool resizable;
  final Size? maxSize;
  final bool? consoleEnabled;
}
