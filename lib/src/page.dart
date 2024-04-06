import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

abstract class DemoFluPage {
  List<PageSection> _sections = [];

  TitleSection titleSection(String title) {
    TitleSection section = TitleSection._(title);
    _sections.add(section);
    return section;
  }

  TextSection text({String text = '', IconData? icon}) {
    TextSection section = TextSection._(text, icon);
    _sections.add(section);
    return section;
  }

  BannerSection infoBanner({String text = '', IconData icon = Icons.info}) {
    return banner(
        text: text,
        background: Colors.blue[50]!,
        border: Colors.blue[700]!,
        icon: icon);
  }

  BannerSection tipBanner({String text = '', IconData icon = Icons.lightbulb}) {
    return banner(
        text: text,
        background: Colors.green[50]!,
        border: Colors.green[700]!,
        icon: icon);
  }

  BannerSection warningBanner(
      {String text = '', IconData icon = Icons.warning}) {
    return banner(
        text: text,
        background: Colors.yellow[100]!,
        border: Colors.yellow[700]!,
        icon: icon);
  }

  BannerSection banner(
      {String text = '', Color? background, Color? border, IconData? icon}) {
    BannerSection section = BannerSection._(
        text: text,
        background: background ?? Colors.blueGrey[50]!,
        border: border ?? Colors.blueGrey[500]!,
        icon: icon);
    _sections.add(section);
    return section;
  }

  DividerSection divider() {
    DividerSection section = DividerSection();
    _sections.add(section);
    return section;
  }

  BulletsSection bulletsSection() {
    BulletsSection section = BulletsSection._();
    _sections.add(section);
    return section;
  }

  WidgetSection widget(WidgetBuilder widgetBuilder,
      {String? title,
      Listenable? listenable,
      double minWidth = 0.0,
      double maxWidth = double.infinity,
      double minHeight = 0.0,
      double maxHeight = double.infinity,
      double? aspectRatio,
      bool bordered = true}) {
    WidgetSection section = WidgetSection._(
        title: title,
        widgetBuilder: widgetBuilder,
        listenable: listenable,
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        maxHeight: maxHeight,
        bordered: bordered);
    _sections.add(section);
    return section;
  }

  CodeSection code(String file,
      {String? title,
      bool wrap = true,
      LoadMode loadMode = LoadMode.readAll,
      String? mark,
      bool discardMultipleEmptyLines = true,
      bool discardLastEmptyLine = true}) {
    CodeSection section = CodeSection(
        title: title,
        file: file,
        wrap: wrap,
        loadMode: loadMode,
        mark: mark,
        discardLastEmptyLine: discardLastEmptyLine,
        discardMultipleEmptyLines: discardMultipleEmptyLines);
    _sections.add(section);
    return section;
  }

  ConsoleSection console({String? title = 'Console', double height = 150}) {
    ConsoleSection section = ConsoleSection(title: title, height: height);
    _sections.add(section);
    return section;
  }
}

abstract class PageSection {}

abstract class TitledPageSection extends PageSection {
  TitledPageSection({required this.title});
  String? title;
}

class DividerSection extends PageSection {}

class TitleSection extends PageSection {
  TitleSection._(this.title);

  final String title;
}

class TextSection extends PageSection {
  TextSection._(this._text, this.iconData);

  IconData? iconData;

  String _text;
  String get text => _text;

  void add(String value) {
    _text += value;
  }
}

class BulletsSection extends PageSection {
  BulletsSection._() {
    bullets = UnmodifiableListView(_bullets);
  }

  List<Bullet> _bullets = [];
  late List<Bullet> bullets;

  Bullet create({int indent = 0, String? text}) {
    indent = indent < 0 ? 0 : indent;
    indent = indent > 3 ? 3 : indent;
    Bullet bullet = Bullet(indent: indent, text: text ?? '');
    _bullets.add(bullet);
    return bullet;
  }
}

class Bullet {
  Bullet({required this.indent, required String text}) : _text = text;

  final int indent;
  String _text;
  String get text => _text;

  void add(String value) {
    _text += value;
  }
}

class WidgetSection extends TitledPageSection {
  WidgetSection._(
      {required super.title,
      required this.widgetBuilder,
      required this.listenable,
      required this.minWidth,
      required this.maxWidth,
      required this.minHeight,
      required this.maxHeight,
      required this.bordered});

  final WidgetBuilder widgetBuilder;
  Listenable? listenable;
  double minWidth;
  double maxWidth;
  double minHeight;
  double maxHeight;
  double? aspectRatio;
  bool bordered;
}

enum LoadMode {
  /// Read all code, including marked sections
  readAll,

  /// Read only the marked code
  readOnlyMarked,

  /// Ignore the marked code
  ignoreMarked
}

class CodeSection extends TitledPageSection {
  CodeSection(
      {required super.title,
      required this.file,
      required this.wrap,
      required this.loadMode,
      required this.mark,
      required this.discardLastEmptyLine,
      required this.discardMultipleEmptyLines});

  final String file;
  bool wrap;
  LoadMode loadMode;
  String? mark;
  bool discardMultipleEmptyLines;
  bool discardLastEmptyLine;
}

class ConsoleSection extends TitledPageSection {
  ConsoleSection({required super.title, required this.height});

  double height;
}

class BannerSection extends PageSection {
  BannerSection._(
      {required String text,
      required this.background,
      required this.border,
      required this.icon})
      : _text = text;

  Color background;
  Color border;
  IconData? icon;

  String _text;
  String get text => _text;

  void add(String value) {
    _text += value;
  }
}

@internal
class PageHelper {
  static List<PageSection> sectionsFrom(DemoFluPage page) {
    return page._sections;
  }
}
