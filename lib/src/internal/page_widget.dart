import 'package:demoflu/src/demo_menu_item.dart';
import 'package:demoflu/src/internal/print_notifier.dart';
import 'package:demoflu/src/page.dart';
import 'package:demoflu/src/internal/model.dart';
import 'package:demoflu/src/internal/provider.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
class DemoFluPageWidget extends StatelessWidget {
  const DemoFluPageWidget({super.key});

  Widget build(BuildContext context) {
    DemoFluModel model = DemoFluProvider.modelOf(context);

    List<Widget> children = [];

    final DemoMenuItem menuItem = model.selectedMenuItem;
    if (menuItem.page != null) {
      final DemoFluPage page = menuItem.page!;

      children.add(BreadcrumbWidget(menuItem: menuItem));

      for (DemoFluPageSection section in page.getSections()) {
        children.add(section.buildWidget(context));
      }
    }

    return LayoutBuilder(builder: (context, constraints) {
      return ListView.separated(
          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) => children[index],
          separatorBuilder: (context, index) => SizedBox(height: 16),
          itemCount: children.length);
    });
  }
}

class BreadcrumbWidget extends StatelessWidget {
  const BreadcrumbWidget({super.key, required this.menuItem});

  final DemoMenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    DemoFluModel model = DemoFluProvider.modelOf(context);

    List<Widget> children = [];
    DemoMenuItem? currentMenuItem = menuItem;
    while (currentMenuItem != null) {
      if (children.isNotEmpty) {
        children.insert(
            0, Icon(Icons.navigate_next, size: 14, color: Colors.grey[600]));
      }
      if (children.isEmpty) {
        children.insert(
            0,
            Text(currentMenuItem.name,
                style: TextStyle(fontWeight: FontWeight.bold)));
      } else {
        if (currentMenuItem.page == null) {
          children.insert(0, Text(currentMenuItem.name));
        } else {
          final DemoMenuItem targetMenuItem = currentMenuItem;
          children.insert(
              0,
              InkWell(
                  onTap: () {
                    PrintNotifier printNotifier =
                        DemoFluProvider.printNotifierOf(context);
                    printNotifier.clear(notify: false);
                    model.selectedMenuItem = targetMenuItem;
                  },
                  child: Text(currentMenuItem.name)));
        }
      }
      currentMenuItem = currentMenuItem.parent;
    }
    return Wrap(
        spacing: 4,
        runSpacing: 4,
        children: children,
        crossAxisAlignment: WrapCrossAlignment.center);
  }
}
