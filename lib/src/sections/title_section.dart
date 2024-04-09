import 'package:demoflu/src/sections/page_section.dart';
import 'package:flutter/material.dart';

/// Session to display a title.
class TitleSection extends PageSection {
  TitleSection(this.title);

  final String title;

  @override
  Widget buildWidget(BuildContext context) {
    TextStyle? style;
    TextTheme textTheme = Theme.of(context).textTheme;
    if (textTheme.bodyMedium != null) {
      style = textTheme.bodyMedium!
          .apply(fontSizeFactor: 2)
          .merge(TextStyle(fontWeight: FontWeight.bold));
    }
    return Text(title, style: style);
  }
}
