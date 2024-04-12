import 'package:demoflu/src/page/page_section.dart';
import 'package:demoflu/src/page/styled_section.dart';
import 'package:demoflu/src/provider.dart';
import 'package:demoflu/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Widget for page sections.
@internal
class PageSectionWidget extends StatelessWidget {
  PageSectionWidget(this.section);

  final PageSection section;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft, child: _titledWidget(context));
  }

  Widget _titledWidget(BuildContext context) {
    if (section is StyledSection) {
      String? title = (section as StyledSection).title;
      if (title != null) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(title), _styledWidget(context)]);
      }
    }
    return _styledWidget(context);
  }

  Widget _styledWidget(BuildContext context) {
    DemoFluTheme theme = DemoFluProvider.themeOf(context);
    if (section is StyledSection) {
      StyledSection styledSection = section as StyledSection;
      return Container(
          padding: styledSection.padding(theme),
          decoration: BoxDecoration(
              color: styledSection.background(theme),
              border: styledSection.border(theme)?.build()),
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: 0,
                  minHeight: section.minHeight,
                  maxWidth: section.maxWidth,
                  maxHeight: section.maxHeight),
              child: section.buildContent(context)));
    }
    return section.buildContent(context);
  }
}
