import 'package:demoflu/src/sections/page_section.dart';
import 'package:flutter/material.dart';

/// Section to display a text.
class TextSection extends PageSection {
  TextSection(this._text, this.iconData);

  IconData? iconData;

  String _text;
  String get text => _text;

  void add(String value) {
    _text += value;
  }

  @override
  Widget buildWidget(BuildContext context) {
    List<InlineSpan> children = [TextSpan(text: text)];
    if (iconData != null) {
      children.insert(
          0,
          WidgetSpan(
              child: Padding(
                  padding: EdgeInsets.only(right: 8), child: Icon(iconData!))));
    }
    return SelectableText.rich(TextSpan(children: children));
  }
}
