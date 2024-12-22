import 'package:demoflu/src/macro.dart';
import 'package:demoflu/src/page/styled_section.dart';
import 'package:demoflu/src/page/text_section_mixin.dart';
import 'package:demoflu/src/provider.dart';
import 'package:flutter/material.dart';

/// Section to display a text.
class TextSection extends StyledSection with TextSectionMixin {
  TextSection(
      {required String text,
      required this.icon,
      required super.marginLeft,
      required super.marginBottom,
      required super.maxWidth,
      required super.border,
      required super.background,
      required super.padding,
      required super.title}) {
    if (text.isNotEmpty) {
      this.text.add(TextSpan(text: text));
    }
  }
  IconData? icon;

  @override
  Widget buildContent(BuildContext context) {
    List<InlineSpan> children = [TextSpan(children: text)];
    if (icon != null) {
      children.insert(
          0,
          WidgetSpan(
              child: Padding(
                  padding: EdgeInsets.only(right: 8), child: Icon(icon!))));
    }
    return SelectableText.rich(TextSpan(children: children));
  }

  @override
  void runMacro({required dynamic id, required BuildContext context}) {
    MacroFactory macroFactory = DemoFluProvider.macroFactoryOf(context);
    TextMacro macro =
        MacroFactoryHelper.getMacro<TextMacro>(id, 'Text', macroFactory);
    macro(context, this);
  }
}
