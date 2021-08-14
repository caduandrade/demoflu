import 'package:flutter/material.dart';

/// Represents a menu item for a widget example.
class Example {
  /// Buils a [Example].
  Example(
      {required this.name,
      required this.content,
      this.resizable,
      this.codeFile,
      this.maxSize,
      this.consoleEnabled});

  final String name;
  final Widget content;
  final String? codeFile;
  final bool? resizable;
  final Size? maxSize;
  final bool? consoleEnabled;
}
