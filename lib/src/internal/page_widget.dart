import 'package:demoflu/src/demo_menu_item.dart';
import 'package:demoflu/src/internal/breadcrumb.dart';
import 'package:demoflu/src/internal/bullets_widget.dart';
import 'package:demoflu/src/internal/console_widget.dart';
import 'package:demoflu/src/internal/example_widget.dart';
import 'package:demoflu/src/internal/source_code_widget.dart';
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
      final DemoFluPage page = menuItem.page!();

      children.add(BreadcrumbWidget(menuItem: menuItem));
      children.addAll(_widgetsFromPage(page));
    }

    return LayoutBuilder(builder: (context, constraints) {
      return ListView.separated(
          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) => children[index],
          separatorBuilder: (context, index) => SizedBox(height: 16),
          itemCount: children.length);
    });
  }

  List<Widget> _widgetsFromPage(DemoFluPage page) {
    List<Widget> list = [];
    for (PageSection section in PageHelper.sectionsFrom(page)) {
      if (section is TextSection) {
        list.add(SelectableText(section.text));
      } else if (section is ExampleSection) {
        list.add(ExampleWidget(section));
      } else if (section is DartCodeSection) {
        list.add(SourceCodeWidget(
          title: section.title,
          file: section.file,
          wrap: section.wrap,
          ignoreEnabled: section.ignoreEnabled,
          key: ValueKey(section.file),
        ));
      } else if (section is ConsoleSection) {
        list.add(ConsoleWidget(title: section.title, height: section.height));
      } else if (section is BulletsSection) {
        list.add(BulletsWidget(bullets: section.bullets));
      } else if (section is TitleSection) {
        list.add(Text(section.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
      } else {
        list.add(Text(section.runtimeType.toString()));
      }
    }
    return list;
  }
}
