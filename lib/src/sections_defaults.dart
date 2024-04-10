import 'package:flutter/material.dart';

/// Provides storage for default attribute values of screen sections,
/// facilitating consistent initialization across various section instances.
class SectionDefaults {
  SectionDefaults(
      {this.widgetBackground,
      this.sectionBottom = 24,
      Color? codeBackground,
      EdgeInsetsGeometry? codePadding})
      : this.codeBackground = codeBackground ?? Colors.grey[100],
        this.codePadding = codePadding ?? EdgeInsets.all(16);

  /// Bottom gap
  final double sectionBottom;

  /// Widget section background.
  final Color? widgetBackground;

  /// Code section background.
  final Color? codeBackground;

  /// Code section padding.
  final EdgeInsetsGeometry? codePadding;
}
