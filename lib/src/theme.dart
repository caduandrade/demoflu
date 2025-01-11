import 'dart:math' as math;
import 'package:demoflu/src/page/borders/section_border.dart';
import 'package:demoflu/src/page/borders/solid_border.dart';
import 'package:flutter/material.dart';

const Color _grey100 = Color(0xFFF5F5F5);
const Color _grey200 = Color(0xFFEEEEEE);
const Color _grey300 = Color(0xFFE0E0E0);
const Color _grey400 = Color(0xFFBDBDBD);
const Color _grey800 = Color(0xFF424242);

const Color _defaultAppBackground = Color(0xFFFAFAFA);
const Color _defaultTextColor = Color(0xFF555555);

/// Provides storage for default theme.
class DemoFluTheme {
  DemoFluTheme(
      {this.bulletsBorderColor = _grey400,
      this.bulletsBorderIconColor = _grey800,
      this.arrowBorderColor = _grey400,
      this.solidBorderColor = _grey400,
      this.appBackground = _defaultAppBackground,
      this.textColor = _defaultTextColor,
      double sectionMarginLeft = 0,
      double sectionMarginBottom = 24,
      this.dividerColor = _grey300,
      this.dividerThickness = 1,
      this.codeBackground = _grey100,
      this.codePadding = const EdgeInsets.all(16),
      this.codeBorder = const SolidBorder(color: _grey300),
      this.consoleBorder = const SolidBorder(color: _grey300),
      this.widgetBackground})
      : this.sectionMarginLeft = math.max(0, sectionMarginLeft),
        this.sectionMarginBottom = math.max(0, sectionMarginBottom);

  final Color appBackground;

  final Color textColor;

  /// Bullets border color
  final Color bulletsBorderColor;

  /// Bullets border icon color
  final Color bulletsBorderIconColor;

  /// Arrow border color
  final Color arrowBorderColor;

  /// Solid border color
  final Color solidBorderColor;

  /// Section margin left
  final double sectionMarginLeft;

  /// Section margin left
  final double sectionMarginBottom;

  /// Divider section color
  final Color dividerColor;

  /// Divider section thickness
  final double dividerThickness;

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
