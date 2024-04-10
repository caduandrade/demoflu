import 'package:demoflu/src/demo_menu_item.dart';
import 'package:demoflu/src/internal/breadcrumb.dart';
import 'package:demoflu/src/page.dart';
import 'package:demoflu/src/internal/model.dart';
import 'package:demoflu/src/internal/provider.dart';
import 'package:demoflu/src/sections/page_section.dart';
import 'package:demoflu/src/sections_defaults.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Widget for page.
@internal
class DemoFluPageWidget extends StatelessWidget {
  const DemoFluPageWidget({super.key});

  Widget build(BuildContext context) {
    DemoFluModel model = DemoFluProvider.modelOf(context);
    SectionDefaults defaults = DemoFluProvider.sectionDefaultsOf(context);

    List<Widget> children = [];

    final DemoMenuItem menuItem = model.selectedMenuItem;
    if (menuItem.page != null) {
      final DemoFluPage page = menuItem.page!();

      children.add(BreadcrumbWidget(menuItem: menuItem));
      children.add(SizedBox(height: 24));
      List<PageSection> sections = PageHelper.sectionsFrom(page);
      for(int i = 0;i < sections.length; i++) {
        PageSection section = sections[i];
        children.add(section.buildWidget(context));
        if(i<sections.length-1) {
          final double bottom = section.bottom ?? defaults.sectionBottom;
          if (bottom > 0) {
            children.add(SizedBox(height: bottom));
          }
        }
      }
    }

    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.fromLTRB(32, 16, 32, 32),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children)));
  }
}
