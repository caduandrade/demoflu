import 'package:demoflu/src/internal/sections/titled_widget.dart';
import 'package:demoflu/src/sections/widget_section.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Container for widget example session
@internal
class WidgetContainer extends StatelessWidget {
  WidgetContainer(this.section);

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
        child: TitledWidget(
            child: section.widgetBuilder(context), section: section));
  }
}
