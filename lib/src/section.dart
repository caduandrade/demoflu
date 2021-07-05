import 'package:demoflu/src/example.dart';

/// Represents a menu section.
class Section {
  /// Builds a [Section].
  const Section({this.name, required this.examples});

  final String? name;
  final List<Example> examples;
}
