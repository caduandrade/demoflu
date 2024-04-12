import 'package:demoflu/src/page/styled_section.dart';
import 'package:demoflu/src/theme.dart';
import 'package:flutter/widgets.dart';

/// Section to display a widget.
class WidgetSection extends StyledSection {
  WidgetSection(
      {required super.title,
      required this.widgetBuilder,
      required super.maxWidth,
      required this.minHeight,
      required this.maxHeight,
      required super.background,
      required super.padding,
      required this.listenable,
      required super.border,
      required super.marginLeft,
      required super.marginBottom});

  double minHeight;
  double maxHeight;

  final WidgetBuilder widgetBuilder;
  Listenable? listenable;

  @override
  Widget buildContent(BuildContext context) {
    return _Widget(this);
  }

  @override
  Color? getBackgroundFromTheme(DemoFluTheme theme) {
    return theme.widgetBackground;
  }
}

/// Container for widget example section
class _Widget extends StatelessWidget {
  _Widget(this.section);

  final WidgetSection section;

  @override
  Widget build(BuildContext context) {
    if (section.listenable != null) {
      return ListenableBuilder(
          listenable: section.listenable!,
          builder: (BuildContext context, Widget? child) {
            return section.widgetBuilder(context);
          });
    }
    return section.widgetBuilder(context);
  }
}
