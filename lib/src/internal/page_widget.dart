import 'package:demoflu/src/demo_menu_item.dart';
import 'package:demoflu/src/internal/banner_widget.dart';
import 'package:demoflu/src/internal/breadcrumb.dart';
import 'package:demoflu/src/internal/bullets_widget.dart';
import 'package:demoflu/src/internal/console_widget.dart';
import 'package:demoflu/src/internal/example_widget.dart';
import 'package:demoflu/src/internal/source_code_widget.dart';
import 'package:demoflu/src/page.dart';
import 'package:demoflu/src/internal/model.dart';
import 'package:demoflu/src/internal/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      children.addAll(_widgetsFromPage(context, page));
    }

    return LayoutBuilder(builder: (context, constraints) {
      return ListView.separated(
          padding: EdgeInsets.fromLTRB(32, 16, 32, 32),
          itemBuilder: (context, index) => children[index],
          separatorBuilder: (context, index) => SizedBox(height: 16),
          itemCount: children.length);
    });
  }

  List<Widget> _widgetsFromPage(BuildContext context, DemoFluPage page) {
    List<Widget> list = [];
    for (PageSection section in PageHelper.sectionsFrom(page)) {
      if (section is TextSection) {
        List<InlineSpan> children = [TextSpan(text: section.text)];
        if (section.iconData != null) {
          children.insert(
              0,
              WidgetSpan(
                  child: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(section.iconData!))));
        }
        list.add(SelectableText.rich(TextSpan(children: children)));
      } else if (section is WidgetSection) {
        list.add(WidgetContainer(section));
      } else if (section is SourceCodeSection) {
        list.add(SourceCodeWidget(
          title: section.title,
          file: section.file,
          wrap: section.wrap,
          ignoreEnabled: section.ignoreEnabled,
          discardLastEmptyLine: section.discardLastEmptyLine,
          discardMultipleEmptyLines: section.discardMultipleEmptyLines,
          key: ValueKey(section.file),
        ));
      } else if (section is BannerSection) {
        list.add(BannerWidget(
            text: TextSpan(text: section.text),
            background: section.background,
            border: section.border,
            icon: section.icon));
      } else if (section is ConsoleSection) {
        list.add(ConsoleWidget(title: section.title, height: section.height));
      } else if (section is BulletsSection) {
        list.add(BulletsWidget(bullets: section.bullets));
      } else if (section is TitleSection) {
        TextStyle? style;
        TextTheme textTheme = Theme.of(context).textTheme;
        if (textTheme.bodyMedium != null) {
          style = textTheme.bodyMedium!
              .apply(fontSizeFactor: 2)
              .merge(TextStyle(fontWeight: FontWeight.bold));
        }
        list.add(Text(section.title, style: style));
      } else {
        list.add(Text(section.runtimeType.toString()));
      }
    }
    return list;
  }
}
