import 'package:flutter/material.dart';

/// Provides storage for default attribute values of screen sections,
/// facilitating consistent initialization across various section instances.
class SectionDefaults {
  const SectionDefaults({this.widgetBackground, this.spaceHeight = 24});

  /// Widget section background.
  final Color? widgetBackground;

  /// Space height.
  final double spaceHeight;
}
