import 'package:demoflu/src/page/banner_section.dart';
import 'package:demoflu/src/page/borders/section_border.dart';
import 'package:demoflu/src/page/console_section.dart';
import 'package:demoflu/src/page/text_section.dart';
import 'package:demoflu/src/page/bullets_section.dart';
import 'package:demoflu/src/page/code_section.dart';
import 'package:demoflu/src/page/divider_section.dart';
import 'package:demoflu/src/page/page_section.dart';
import 'package:demoflu/src/page/heading_section.dart';
import 'package:demoflu/src/page/widget_section.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
mixin SectionCollectionMixin {
  List<PageSection> _sections = [];

  /// Creates a section to display a heading.
  HeadingSection heading(String text,
      {double? marginLeft,
      double? marginBottom,
      double maxWidth = double.infinity}) {
    HeadingSection section = HeadingSection(
        text: text,
        marginLeft: marginLeft,
        marginBottom: marginBottom,
        maxWidth: maxWidth);
    _sections.add(section);
    return section;
  }

  /// Creates a section to display a text.
  TextSection text(
      {String text = '',
      IconData? icon,
      String? title,
      double? marginLeft,
      double? marginBottom,
      SectionBorder? border,
      Color? background,
      EdgeInsetsGeometry? padding,
      double maxWidth = double.infinity}) {
    TextSection section = TextSection(
        text: text,
        icon: icon,
        marginLeft: marginLeft,
        marginBottom: marginBottom,
        maxWidth: maxWidth,
        border: border,
        background: background,
        padding: padding,
        title: title);
    _sections.add(section);
    return section;
  }

  /// Create a section to display an informational banner.
  BannerSection infoBanner(
      {double? marginLeft,
      double? marginBottom,
      String text = '',
      IconData icon = Icons.info,
      double maxWidth = double.infinity}) {
    return banner(
        marginLeft: marginLeft,
        marginBottom: marginBottom,
        text: text,
        background: Colors.blue[50]!,
        border: Colors.blue[700]!,
        icon: icon,
        maxWidth: maxWidth);
  }

  /// Create a section to display a tip banner.
  BannerSection tipBanner(
      {double? marginLeft,
      double? marginBottom,
      String text = '',
      IconData icon = Icons.lightbulb,
      double maxWidth = double.infinity}) {
    return banner(
        marginLeft: marginLeft,
        marginBottom: marginBottom,
        text: text,
        background: Colors.green[50]!,
        border: Colors.green[700]!,
        icon: icon,
        maxWidth: maxWidth);
  }

  /// Create a section to display an warning banner.
  BannerSection warningBanner(
      {double? marginLeft,
      double? marginBottom,
      String text = '',
      IconData icon = Icons.warning,
      double maxWidth = double.infinity}) {
    return banner(
        marginLeft: marginLeft,
        marginBottom: marginBottom,
        text: text,
        background: Colors.yellow[100]!,
        border: Colors.yellow[700]!,
        icon: icon,
        maxWidth: maxWidth);
  }

  /// Create a section to display a banner.
  BannerSection banner(
      {double? marginLeft,
      double? marginBottom,
      String text = '',
      Color? background,
      Color? border,
      IconData? icon,
      double maxWidth = double.infinity}) {
    BannerSection section = BannerSection(
        marginLeft: marginLeft,
        marginBottom: marginBottom,
        text: text,
        background: background ?? Colors.blueGrey[50]!,
        border: border ?? Colors.blueGrey[500]!,
        icon: icon,
        maxWidth: maxWidth);
    _sections.add(section);
    return section;
  }

  /// Create a section to display a divider.
  DividerSection divider(
      {double? marginLeft,
      double? marginBottom,
      double maxWidth = double.infinity,
      double? thickness,
      Color? color}) {
    DividerSection section = DividerSection(
        marginLeft: marginLeft,
        marginBottom: marginBottom,
        maxWidth: maxWidth,
        color: color,
        thickness: thickness);
    _sections.add(section);
    return section;
  }

  /// Create a section to display bullets.
  BulletsSection bulletsSection(
      {String? title,
      double? marginLeft,
      double? marginBottom,
      SectionBorder? border,
      Color? background,
      EdgeInsetsGeometry? padding,
      double maxWidth = double.infinity,
      double spacing = 4}) {
    BulletsSection section = BulletsSection(
        title: title,
        marginLeft: marginLeft,
        marginBottom: marginBottom,
        padding: padding,
        border: border,
        background: background,
        maxWidth: maxWidth,
        spacing: spacing);
    _sections.add(section);
    return section;
  }

  /// Create a section to display some widget.
  /// Use this section to demonstrate your package widget.
  WidgetSection widget(WidgetBuilder widgetBuilder,
      {String? title,
      Listenable? listenable,
      double maxWidth = double.infinity,
      double minHeight = 0.0,
      double maxHeight = double.infinity,
      SectionBorder? border,
      Color? background,
      EdgeInsetsGeometry? padding,
      double? marginLeft,
      double? marginBottom}) {
    WidgetSection section = WidgetSection(
        title: title,
        widgetBuilder: widgetBuilder,
        listenable: listenable,
        padding: padding,
        maxWidth: maxWidth,
        minHeight: minHeight,
        maxHeight: maxHeight,
        background: background,
        border: border,
        marginLeft: marginLeft,
        marginBottom: marginBottom);
    _sections.add(section);
    return section;
  }

  /// Creates a section to display some source code.
  CodeSection code(String file,
      {String? title,
      double? marginLeft,
      double? marginBottom,
      LoadMode loadMode = LoadMode.readAll,
      String? mark,
      bool discardMultipleEmptyLines = true,
      bool discardLastEmptyLine = true,
      bool discardMarks = false,
      SectionBorder? border,
      Color? background,
      EdgeInsetsGeometry? padding,
      double maxWidth = double.infinity}) {
    CodeSection section = CodeSection(
        title: title,
        marginLeft: marginLeft,
        marginBottom: marginBottom,
        file: file,
        loadMode: loadMode,
        mark: mark,
        border: border,
        background: background,
        padding: padding,
        discardMarks: discardMarks,
        discardLastEmptyLine: discardLastEmptyLine,
        discardMultipleEmptyLines: discardMultipleEmptyLines,
        maxWidth: maxWidth);
    _sections.add(section);
    return section;
  }

  /// Create a section to display console output.
  ConsoleSection console(
      {String? title = 'Console',
      double height = 150,
      bool bordered = true,
      Color? background = Colors.white,
      EdgeInsetsGeometry? padding,
      SectionBorder? border,
      double? marginLeft,
      double? marginBottom,
      double maxWidth = double.infinity}) {
    ConsoleSection section = ConsoleSection(
        title: title,
        height: height,
        marginLeft: marginLeft,
        marginBottom: marginBottom,
        border: border,
        background: background,
        padding: padding ?? EdgeInsets.all(8),
        maxWidth: maxWidth);
    _sections.add(section);
    return section;
  }
}

@internal
class SectionCollectionHelper {
  static List<PageSection> sectionsOf(SectionCollectionMixin collection) =>
      collection._sections;

  static addSectionOn(PageSection section, SectionCollectionMixin collection) {
    collection._sections.add(section);
  }
}
