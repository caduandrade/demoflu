import 'package:flutter/material.dart';

class DFExample {
  const DFExample(
      {required this.name,
      required this.builder,
      this.resizable = false,
      this.codeFile,
      this.maxSize});

  final String name;
  final WidgetBuilder builder;
  final bool resizable;
  final String? codeFile;
  final Size? maxSize;
}
