import 'package:demoflu/src/macro.dart';
import 'package:demoflu/src/page/page_section.dart';
import 'package:demoflu/src/provider.dart';
import 'package:flutter/material.dart';

/// Section to display a title.
class HeadingSection extends PageSection {
  HeadingSection(
      {required super.marginLeft,
      required super.marginBottom,
      required super.maxWidth,
      required this.text});

  String text;

  @override
  Widget buildContent(BuildContext context) {
    TextStyle? style;
    TextTheme textTheme = Theme.of(context).textTheme;
    if (textTheme.bodyMedium != null) {
      style = textTheme.bodyMedium!
          .apply(fontSizeFactor: 2)
          .merge(TextStyle(fontWeight: FontWeight.bold));
    }
    return Text(text, style: style);
  }

  @override
  void runMacro({required dynamic id, required BuildContext context}) {
    MacroFactory macroFactory = DemoFluProvider.macroFactoryOf(context);
    HeadingMacro macro =
        MacroFactoryHelper.getMacro<HeadingMacro>(id, 'Heading', macroFactory);
    macro(context, this);
  }
}
