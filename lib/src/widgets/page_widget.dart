import 'package:demoflu/src/menu_item.dart';
import 'package:demoflu/src/page/page.dart';
import 'package:demoflu/src/model.dart';
import 'package:demoflu/src/provider.dart';
import 'package:demoflu/src/widgets/breadcrumb.dart';
import 'package:demoflu/src/widgets/section_collection_widget.dart';
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
    if (menuItem.page != null) {
      final DemoFluPage page = menuItem.page!();
      children.add(BreadcrumbWidget(menuItem: menuItem));
      children.add(SizedBox(height: 24));
      children.add(SectionCollectionWidget(collection: page));
    }

    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.fromLTRB(32, 16, 32, 32),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children)));
  }
}
