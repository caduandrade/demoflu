import 'package:demoflu/src/internal/sections/widget_section_ui.dart';
import 'package:demoflu/src/sections/borders/arrow_down_border.dart';
import 'package:demoflu/src/sections/borders/bullet_border.dart';
import 'package:demoflu/src/sections/borders/section_border.dart';
import 'package:demoflu/src/sections/borders/solid_border.dart';
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
      required this.padding,
      required this.border});

  final WidgetBuilder widgetBuilder;
  Listenable? listenable;
  String? title;
  EdgeInsetsGeometry? padding;
  double minWidth;
  double maxWidth;
  double minHeight;
  double maxHeight;
  Color? background;
  SectionBorder border;

  @override
  Widget buildWidget(BuildContext context) {
    return WidgetSectionUI(this);
  }

  void borderless() {
    border = Borderless();
  }

  void bulletBorder() {
    border = BulletBorder();
  }

  SolidBorder solidBorder({Color? color}) {
    border = SolidBorder(color: color);
    return border as SolidBorder;
  }

  void arrowDownBorder() {
    border = ArrowDownBorder();
  }
}
