import 'package:demoflu/src/internal/sections/widget_section_ui.dart';
import 'package:demoflu/src/sections/container_section.dart';
import 'package:flutter/widgets.dart';

/// Section to display a widget.
class WidgetSection extends ContainerSection {
  WidgetSection(
      {required super.title,
      required this.widgetBuilder,
      required this.listenable,
      required super.minWidth,
      required super.maxWidth,
      required super.minHeight,
      required super.maxHeight,
      required super.bordered,
      required super.background,
      required super.padding});

  final WidgetBuilder widgetBuilder;
  Listenable? listenable;

  @override
  Widget buildWidget(BuildContext context) {
    return WidgetSectionUI(this);
  }
}
