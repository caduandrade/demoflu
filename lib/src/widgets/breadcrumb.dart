import 'package:demoflu/src/menu_item.dart';
import 'package:demoflu/src/model.dart';
import 'package:demoflu/src/print_notifier.dart';
import 'package:demoflu/src/provider.dart';
import 'package:demoflu/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Breadcrumb in the page.
@internal
class BreadcrumbWidget extends StatelessWidget {
  const BreadcrumbWidget({super.key, required this.menuItem});

  final DemoMenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    DemoFluModel model = DemoFluProvider.modelOf(context);
    DemoFluTheme theme = DemoFluProvider.themeOf(context);

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
                style: TextStyle(color: theme.textColor, fontWeight: FontWeight.bold)));
      } else {
        if (currentMenuItem.page == null) {
          children.insert(0, Text(currentMenuItem.name,style: TextStyle(color: theme.textColor)));
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
