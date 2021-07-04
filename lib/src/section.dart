import 'package:demoflu/src/example.dart';

/// Represents a menu section.
class DFSection {
  /// Builds a [DFSection].
  const DFSection({this.name, required this.examples});

  final String? name;
  final List<DFExample> examples;
}
