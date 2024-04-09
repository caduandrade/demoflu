import 'package:demoflu/src/internal/sections/widgets/titled_widget.dart';
import 'package:demoflu/src/sections/widget_section.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Container for widget example section
@internal
class WidgetSectionUI extends StatelessWidget {
  WidgetSectionUI(this.section);

  final WidgetSection section;

  @override
  Widget build(BuildContext context) {
    if (section.listenable != null) {
      return ListenableBuilder(
          listenable: section.listenable!,
          builder: (BuildContext context, Widget? child) {
            return _container(context);
          });
    }
    return _container(context);
  }

  Widget _container(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child:
            TitledWidget(title: section.title, child: buildContent(context)));
  }

  Widget buildContent(BuildContext context) {
    return Container(
        padding: section.padding,
        decoration: BoxDecoration(color: section.background),
        child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: section.minWidth,
                minHeight: section.minHeight,
                maxWidth: section.maxWidth,
                maxHeight: section.maxHeight),
            child: section.widgetBuilder(context)));
  }
}
