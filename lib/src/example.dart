import 'package:flutter/material.dart';

typedef ExampleWidgetBuilder = Widget Function(
    ButtonClickNotifier buttonClickNotifier);

typedef OnButtonClick = void Function(int buttonIndex);

class ButtonClickNotifier {
  OnButtonClick? _onClick;

  void register(OnButtonClick onClick) {
    _onClick = onClick;
  }

  void unregister() {
    _onClick = null;
  }

  void notifyClick(int buttonIndex) {
    if (_onClick != null) {
      _onClick!(buttonIndex);
    }
  }
}

/// Represents a menu item for a widget example.
class Example {
  /// Buils a [Example].
  Example(
      {required this.name,
      required this.builder,
      this.resizable,
      this.codeFile,
      this.maxSize,
      this.consoleEnabled,
      this.buttons});

  int _index = -1;
  int get index => _index;
  set index(int index) {
    if (_index != -1) {
      throw StateError('The index has already been set.');
    }
    _index = index;
  }

  final String name;
  final ExampleWidgetBuilder builder;
  final String? codeFile;
  final bool? resizable;
  final Size? maxSize;
  final bool? consoleEnabled;
  final List<String>? buttons;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Example &&
          runtimeType == other.runtimeType &&
          _index == other._index;

  @override
  int get hashCode => _index.hashCode;
}
