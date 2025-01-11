import 'package:demoflu/src/link.dart';
import 'package:demoflu/src/model.dart';
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
    if (section is StyledSection) {
      StyledSection styledSection = section as StyledSection;
      String? title = styledSection.title;
      DemoFluLink? link = styledSection.link;
      if (title != null || link != null) {
        List<Widget> children = [];
        if (title != null) {
          children.add(Text(title));
        }
        children.add(_styledWidget(context));
        if (link != null) {
          children.add(_link(context, link));
        }
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: children);
      }
    }
    return _styledWidget(context);
  }

  Widget _link(BuildContext context, DemoFluLink link) {
    DemoFluModel model = DemoFluProvider.modelOf(context);
    return TextButton.icon(
        onPressed: () => model.link = link,
        icon: Icon(Icons.code),
        label: Text("View source code"),
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue,
        ));
  }

  Widget _styledWidget(BuildContext context) {
    DemoFluTheme theme = DemoFluProvider.themeOf(context);
    if (section is StyledSection) {
      StyledSection styledSection = section as StyledSection;
      return Container(
          padding:
              styledSection.padding ?? styledSection.getPaddingFromTheme(theme),
          decoration: BoxDecoration(
              color: styledSection.background ??
                  styledSection.getBackgroundFromTheme(theme),
              border: styledSection.border != null
                  ? styledSection.border!.build(context)
                  : styledSection.getBorderFromTheme(theme)?.build(context)),
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
