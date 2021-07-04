import 'package:flutter/material.dart';

/// Represents a menu item for a widget example.
class DFExample {
  /// Buils a [DFExample].
  DFExample(
      {required this.name,
      required this.builder,
      this.resizable = false,
      this.codeFile,
      this.maxSize,
      this.consoleEnabled});

  int _index = -1;
  int get index => _index;
  set index(int index) {
    if (_index != -1) {
      throw StateError('The index has already been set.');
    }
    _index = index;
  }

  final String name;
  final WidgetBuilder builder;
  final String? codeFile;
  final bool resizable;
  final Size? maxSize;
  final bool? consoleEnabled;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DFExample &&
          runtimeType == other.runtimeType &&
          _index == other._index;

  @override
  int get hashCode => _index.hashCode;
}
