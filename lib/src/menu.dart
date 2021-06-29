import 'package:demoflu/demoflu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemoFluMenuItem {
  const DemoFluMenuItem(
      {required this.text,
      required this.builder,
      this.resizableContent = false,
      this.codeFile,
      this.limitedSize});

  final String text;
  final WidgetBuilder builder;
  final bool resizableContent;
  final String? codeFile;
  final Size? limitedSize;
}

class DemoFluMenuSection {
  final String? text;
  final List<DemoFluMenuItem> menuItems;

  const DemoFluMenuSection({this.text, required this.menuItems});
}
