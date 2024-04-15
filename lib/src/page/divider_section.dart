import 'package:demoflu/src/macro.dart';
import 'package:demoflu/src/page/page_section.dart';
import 'package:demoflu/src/provider.dart';
import 'package:demoflu/src/theme.dart';
import 'package:flutter/material.dart';

/// Section to display a divider.
class DividerSection extends PageSection {
  DividerSection(
      {required super.marginLeft,
      required super.marginBottom,
      required super.maxWidth,
      required this.thickness,
      required this.color});

  Color? color;
  double? thickness;

  @override
  Widget buildContent(BuildContext context) {
    DemoFluTheme theme = DemoFluProvider.themeOf(context);
    double thickness = this.thickness ?? theme.dividerThickness;
    return Divider(
        height: thickness,
        color: color ?? theme.dividerColor,
        thickness: thickness);
  }

  @override
  void runMacro({required dynamic id, required BuildContext context}) {
    MacroFactory macroFactory = DemoFluProvider.macroFactoryOf(context);
    DividerMacro macro =
        MacroFactoryHelper.getMacro<DividerMacro>(id, 'Divider', macroFactory);
    macro(context, this);
  }
}
