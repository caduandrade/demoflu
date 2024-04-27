import 'package:demoflu/src/menu_item.dart';
import 'package:demoflu/src/page/page.dart';
import 'package:demoflu/src/page/page_sections.dart';
import 'package:demoflu/src/widgets/breadcrumb.dart';
import 'package:demoflu/src/widgets/section_collection_widget.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Widget for page.
@internal
class DemoFluPageWidget extends StatefulWidget {
  const DemoFluPageWidget({required this.menuItem, super.key});

  final DemoMenuItem menuItem;

  @override
  State<StatefulWidget> createState() => DemoFluPageState();
}

class DemoFluPageState extends State<DemoFluPageWidget> {
  late DemoFluPage? _page;

  @override
  void initState() {
    super.initState();
    if (widget.menuItem.page != null) {
      _page = widget.menuItem.page!();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (_page != null) {
      PageSections sections = _page!.buildSections(context);
      children.add(BreadcrumbWidget(menuItem: widget.menuItem));
      children.add(SizedBox(height: 24));
      children.add(SectionCollectionWidget(collection: sections));
    }

    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.fromLTRB(32, 16, 32, 32),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children)));
  }
}
