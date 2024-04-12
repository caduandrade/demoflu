import 'package:demoflu/src/provider.dart';
import 'package:demoflu/src/page/page_section.dart';
import 'package:demoflu/src/page/section_collection.dart';
import 'package:demoflu/src/theme.dart';
import 'package:demoflu/src/widgets/page_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
class SectionCollectionWidget extends StatelessWidget {
  const SectionCollectionWidget({super.key, required this.collection});

  final SectionCollectionMixin collection;

  @override
  Widget build(BuildContext context) {
    DemoFluTheme theme = DemoFluProvider.themeOf(context);

    List<PageSection> sections = SectionCollectionHelper.sectionsOf(collection);

    List<Widget> children = [];
    for (int i = 0; i < sections.length; i++) {
      PageSection section = sections[i];

      double marginLeft = section.marginLeft ?? theme.sectionMarginLeft;
      double marginBottom = section.marginBottom ?? theme.sectionMarginBottom;
      if (i == sections.length - 1) {
        marginBottom = 0;
      }

      Widget child = PageSectionWidget(section);
      if (marginLeft > 0 || marginBottom > 0) {
        child = Padding(
            padding: EdgeInsets.only(left: marginLeft, bottom: marginBottom),
            child: child);
      }
      children.add(child);
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
  }
}
