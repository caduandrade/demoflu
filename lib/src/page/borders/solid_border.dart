import 'package:demoflu/demoflu.dart';
import 'package:demoflu/src/page/borders/section_border.dart';
import 'package:flutter/material.dart';

class SolidBorder extends SectionBorder {
  const SolidBorder({required this.color});

  final Color color;

  @override
  BoxBorder? build() {
    return Border.all(color: color, width: 1);
  }
}
