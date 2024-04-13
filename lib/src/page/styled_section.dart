import 'package:demoflu/src/page/borders/arrow_down_border.dart';
import 'package:demoflu/src/page/borders/bullet_border.dart';
import 'package:demoflu/src/page/borders/section_border.dart';
import 'package:demoflu/src/page/borders/solid_border.dart';
import 'package:demoflu/src/page/page_section.dart';
import 'package:demoflu/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// Styled section.
@internal
abstract class StyledSection extends PageSection {
  StyledSection(
      {required super.marginLeft,
      required super.marginBottom,
      required super.maxWidth,
      required this.title,
      required this.padding,
      required this.background,
      required this.border});

  String? title;

  EdgeInsetsGeometry? padding;

  EdgeInsetsGeometry? getPaddingFromTheme(DemoFluTheme theme) => null;

  Color? background;

  Color? getBackgroundFromTheme(DemoFluTheme theme) => null;

  SectionBorder? border;

  SectionBorder? getBorderFromTheme(DemoFluTheme theme) => null;

  void borderless() {
    border = null;
  }

  void bulletBorder(
      {double top = 0,
      double diameter = 10,
      double iconWeight = .8,
      double shiftIconX = 0,
      double shiftIconY = 0,
      IconData? icon,
      required Color color,
      double thickness = 2}) {
    border = BulletBorder(
        top: top,
        diameter: diameter,
        icon: icon,
        iconWeight: iconWeight,
        shiftIconX: shiftIconX,
        shiftIconY: shiftIconY,
        color: color,
        thickness: thickness);
  }

  void solidBorder({required Color color}) {
    border = SolidBorder(color: color);
  }

  void arrowDownBorder() {
    border = ArrowDownBorder();
  }
}
