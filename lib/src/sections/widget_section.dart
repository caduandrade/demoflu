import 'package:demoflu/src/internal/sections/widget_section_ui.dart';
import 'package:demoflu/src/sections/page_section.dart';
import 'package:flutter/widgets.dart';

/// Section to display a widget.
class WidgetSection extends PageSection {
  WidgetSection(
      {required this.title,
      required this.widgetBuilder,
      required this.listenable,
      required this.minWidth,
      required this.maxWidth,
      required this.minHeight,
      required this.maxHeight,
      required this.background,
      required this.padding});

  final WidgetBuilder widgetBuilder;
  Listenable? listenable;
  String? title;
  EdgeInsetsGeometry? padding;
  double minWidth;
  double maxWidth;
  double minHeight;
  double maxHeight;
  Color? background;

  @override
  Widget buildWidget(BuildContext context) {
    return WidgetSectionUI(this);
  }
}
