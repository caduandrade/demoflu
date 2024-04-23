import 'package:demoflu/demoflu.dart';
import 'package:demoflu/src/provider.dart';
import 'package:flutter/material.dart';

class SolidBorder extends SectionBorder {
  const SolidBorder({this.color});

  final Color? color;

  @override
  BoxBorder? build(BuildContext context) {
    DemoFluTheme theme = DemoFluProvider.themeOf(context);
    return Border.all(color: color ?? theme.solidBorderColor, width: 1);
  }
}
