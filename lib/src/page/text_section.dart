import 'package:demoflu/src/page/page_section.dart';
import 'package:demoflu/src/page/styled_section.dart';
import 'package:flutter/material.dart';

/// Section to display a text.
class TextSection extends StyledSection {
  TextSection(
      {required String text,
      required this.icon,
      required super.marginLeft,
      required super.marginBottom,
      required super.maxWidth,
      required super.border,
      required super.background,
      required super.padding,
      required super.title})
      : _text = text;

  IconData? icon;

  String _text;
  String get text => _text;

  void add(String value) {
    _text += value;
  }

  @override
  Widget buildContent(BuildContext context) {
    List<InlineSpan> children = [TextSpan(text: text)];
    if (icon != null) {
      children.insert(
          0,
          WidgetSpan(
              child: Padding(
                  padding: EdgeInsets.only(right: 8), child: Icon(icon!))));
    }
    return SelectableText.rich(TextSpan(children: children));
  }
}
