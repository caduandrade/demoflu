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
      required EdgeInsetsGeometry? padding,
      required Color? background,
      required SectionBorder? border})
      : _padding = padding,
        _background = background,
        _border = border;

  String? title;

  EdgeInsetsGeometry? _padding;

  EdgeInsetsGeometry? padding(DemoFluTheme theme) => _padding;

  Color? _background;

  Color? background(DemoFluTheme theme) => _background;

  SectionBorder? _border;

  SectionBorder? border(DemoFluTheme theme) => _border;

  void borderless() {
    _border = null;
  }

  void bulletBorder() {
    _border = BulletBorder();
  }

  void solidBorder({required Color color}) {
    _border = SolidBorder(color: color);
  }

  void arrowDownBorder() {
    _border = ArrowDownBorder();
  }
}
