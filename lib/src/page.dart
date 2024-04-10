import 'package:demoflu/src/sections/banner_section.dart';
import 'package:demoflu/src/sections/borders/section_border.dart';
import 'package:demoflu/src/sections/bullets_section.dart';
import 'package:demoflu/src/sections/code_section.dart';
import 'package:demoflu/src/sections/console_section.dart';
import 'package:demoflu/src/sections/divider_section.dart';
import 'package:demoflu/src/sections/page_section.dart';
import 'package:demoflu/src/sections/text_section.dart';
import 'package:demoflu/src/sections/title_section.dart';
import 'package:demoflu/src/sections/widget_section.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

/// Page to display content in sections.
/// Use different methods to create sections according to your needs.
abstract class DemoFluPage {
  List<PageSection> _sections = [];

  /// Creates a section to display a title.
  TitleSection title(String title) {
    TitleSection section = TitleSection(title);
    _sections.add(section);
    return section;
  }

  /// Creates a section to display a text.
  TextSection text({String text = '', IconData? icon}) {
    TextSection section = TextSection(text, icon);
    _sections.add(section);
    return section;
  }

  /// Create a section to display an informational banner.
  BannerSection infoBanner({String text = '', IconData icon = Icons.info}) {
    return banner(
        text: text,
        background: Colors.blue[50]!,
        border: Colors.blue[700]!,
        icon: icon);
  }

  /// Create a section to display a tip banner.
  BannerSection tipBanner({String text = '', IconData icon = Icons.lightbulb}) {
    return banner(
        text: text,
        background: Colors.green[50]!,
        border: Colors.green[700]!,
        icon: icon);
  }

  /// Create a section to display an warning banner.
  BannerSection warningBanner(
      {String text = '', IconData icon = Icons.warning}) {
    return banner(
        text: text,
        background: Colors.yellow[100]!,
        border: Colors.yellow[700]!,
        icon: icon);
  }

  /// Create a section to display a banner.
  BannerSection banner(
      {String text = '', Color? background, Color? border, IconData? icon}) {
    BannerSection section = BannerSection(
        text: text,
        background: background ?? Colors.blueGrey[50]!,
        border: border ?? Colors.blueGrey[500]!,
        icon: icon);
    _sections.add(section);
    return section;
  }

  /// Create a section to display a divider.
  DividerSection divider() {
    DividerSection section = DividerSection();
    _sections.add(section);
    return section;
  }

  /// Create a section to display bullets.
  BulletsSection bulletsSection() {
    BulletsSection section = BulletsSection();
    _sections.add(section);
    return section;
  }

  /// Create a section to display some widget.
  /// Use this section to demonstrate your package widget.
  WidgetSection widget(WidgetBuilder widgetBuilder,
      {String? title,
      Listenable? listenable,
      double minWidth = 0.0,
      double maxWidth = double.infinity,
      double minHeight = 0.0,
      double maxHeight = double.infinity,
      SectionBorder border = const Borderless(),
      Color? background,
      EdgeInsetsGeometry? padding}) {
    WidgetSection section = WidgetSection(
        title: title,
        widgetBuilder: widgetBuilder,
        listenable: listenable,
        padding: padding,
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        maxHeight: maxHeight,
        background: background,
        border: border);
    _sections.add(section);
    return section;
  }

  /// Creates a section to display some source code.
  CodeSection code(String file,
      {String? title,
      bool wrap = true,
      LoadMode loadMode = LoadMode.readAll,
      String? mark,
      bool discardMultipleEmptyLines = true,
      bool discardLastEmptyLine = true,
      bool bordered = true,
      Color? background,
      EdgeInsetsGeometry? padding}) {
    CodeSection section = CodeSection(
        title: title,
        file: file,
        loadMode: loadMode,
        mark: mark,
        bordered: bordered,
        background: background,
        padding: padding,
        discardLastEmptyLine: discardLastEmptyLine,
        discardMultipleEmptyLines: discardMultipleEmptyLines);
    _sections.add(section);
    return section;
  }

  /// Create a section to display console output.
  ConsoleSection console(
      {String? title = 'Console',
      double height = 150,
      bool bordered = true,
      Color? background = Colors.white,
      EdgeInsetsGeometry? padding}) {
    ConsoleSection section = ConsoleSection(
        title: title,
        height: height,
        bordered: bordered,
        background: background,
        padding: padding ?? EdgeInsets.all(8));
    _sections.add(section);
    return section;
  }
}

@internal
class PageHelper {
  static List<PageSection> sectionsFrom(DemoFluPage page) {
    return page._sections;
  }
}
