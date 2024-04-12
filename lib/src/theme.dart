import 'dart:math' as math;
import 'package:demoflu/src/page/borders/section_border.dart';
import 'package:demoflu/src/page/borders/solid_border.dart';
import 'package:flutter/material.dart';

const Color _grey100 = Color(0xFFF5F5F5);
const Color _grey200 = Color(0xFFEEEEEE);

/// Provides storage for default theme.
class DemoFluTheme {
  DemoFluTheme(
      {this.widgetBackground,
      double sectionMarginLeft = 0,
      double sectionMarginBottom = 24,
      this.codeBackground = _grey100,
      this.codePadding = const EdgeInsets.all(16),
      this.codeBorder = const SolidBorder(color: _grey200),
      this.consoleBorder = const SolidBorder(color: _grey200)})
      : this.sectionMarginLeft = math.max(0, sectionMarginLeft),
        this.sectionMarginBottom = math.max(0, sectionMarginBottom);

  /// Section margin left
  final double sectionMarginLeft;

  /// Section margin left
  final double sectionMarginBottom;

  /// Widget section background.
  final Color? widgetBackground;

  /// Code section background.
  final Color? codeBackground;

  /// Code section padding.
  final EdgeInsetsGeometry? codePadding;

  /// Code border
  final SectionBorder? codeBorder;

  /// Console border
  final SectionBorder? consoleBorder;
}
