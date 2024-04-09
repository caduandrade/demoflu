import 'package:demoflu/src/demo_menu_item.dart';
import 'package:demoflu/src/internal/breadcrumb.dart';
import 'package:demoflu/src/page.dart';
import 'package:demoflu/src/internal/model.dart';
import 'package:demoflu/src/internal/provider.dart';
import 'package:demoflu/src/sections/page_section.dart';
import 'package:demoflu/src/sections/space_section.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Widget for page.
@internal
class DemoFluPageWidget extends StatelessWidget {
  const DemoFluPageWidget({super.key});

  Widget build(BuildContext context) {
    DemoFluModel model = DemoFluProvider.modelOf(context);

    List<Widget> children = [];

    final DemoMenuItem menuItem = model.selectedMenuItem;
    SpaceSection spaceSection = SpaceSection();
    if (menuItem.page != null) {
      final DemoFluPage page = menuItem.page!();

      children.add(BreadcrumbWidget(menuItem: menuItem));
      for (PageSection section in PageHelper.sectionsFrom(page)) {
        if (page.autoSpace) {
          children.add(spaceSection.buildWidget(context));
        }
        children.add(section.buildWidget(context));
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
