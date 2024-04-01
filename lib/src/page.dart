import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

abstract class DemoFluPage {
  List<PageSection> _sections = [];

  TitleSection addTitle(String title) {
    TitleSection section = TitleSection._(title);
    _sections.add(section);
    return section;
  }

  TextSection textSection([String? text]) {
    TextSection section = TextSection._(text ?? '');
    _sections.add(section);
    return section;
  }

  BulletsSection bulletsSection() {
    BulletsSection section = BulletsSection._();
    _sections.add(section);
    return section;
  }

  ExampleSection exampleSection(WidgetBuilder widgetBuilder,
      {String? title,
      Listenable? listenable,
      double minWidth = 0.0,
      double maxWidth = double.infinity,
      double minHeight = 0.0,
      double maxHeight = double.infinity,
      double? aspectRatio}) {
    ExampleSection section = ExampleSection._(
        title: title,
        widgetBuilder: widgetBuilder,
        listenable: listenable,
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        maxHeight: maxHeight);
    _sections.add(section);
    return section;
  }

  DartCodeSection sourceCodeSection(String file,
      {String? title, bool wrap = true, bool ignoreEnabled = true}) {
    DartCodeSection section = DartCodeSection(
        title: title, file: file, wrap: wrap, ignoreEnabled: ignoreEnabled);
    _sections.add(section);
    return section;
  }

  ConsoleSection consoleSection(
      {String? title = 'Console', double height = 150}) {
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

class TitleSection extends PageSection {
  TitleSection._(this.title);

  final String title;
}

class TextSection extends PageSection {
  TextSection._(this._text);

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

class ExampleSection extends TitledPageSection {
  ExampleSection._(
      {required super.title,
      required this.widgetBuilder,
      required this.listenable,
      required this.minWidth,
      required this.maxWidth,
      required this.minHeight,
      required this.maxHeight});

  final WidgetBuilder widgetBuilder;
  Listenable? listenable;
  double minWidth;
  double maxWidth;
  double minHeight;
  double maxHeight;
  double? aspectRatio;
}

class DartCodeSection extends TitledPageSection {
  DartCodeSection(
      {required super.title,
      required this.file,
      required this.wrap,
      required this.ignoreEnabled});

  final String file;
  bool wrap;
  bool ignoreEnabled;
}

class ConsoleSection extends TitledPageSection {
  ConsoleSection({required super.title, required this.height});

  double height;
}

@internal
class PageHelper {
  static List<PageSection> sectionsFrom(DemoFluPage page) {
    return page._sections;
  }
}
