import 'package:demoflu/src/example.dart';

/// Represents a menu item in the app menu.
class DemoMenuItem {
  /// Builds a [DemoMenuItem].
  DemoMenuItem(
      {required this.name,
      this.example,
      this.italic = false,
      this.indentation = 1});

  final String name;
  final bool italic;
  final int indentation;
  final AbstractExample? example;
}
