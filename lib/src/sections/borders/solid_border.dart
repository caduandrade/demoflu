import 'package:demoflu/demoflu.dart';
import 'package:demoflu/src/sections/borders/section_border.dart';
import 'package:flutter/material.dart';


class SolidBorder extends SectionBorder {

  SolidBorder({required Color? color}):color=color??Colors.grey[200]!;

  Color color;

  @override
  BoxBorder? build() {
    return Border.all(color: color, width: 1);
  }


}

