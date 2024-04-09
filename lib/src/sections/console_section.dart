import 'package:demoflu/src/internal/sections/console_section_ui.dart';
import 'package:demoflu/src/sections/page_section.dart';
import 'package:flutter/widgets.dart';

/// Section to display a console output.
class ConsoleSection extends PageSection {
  ConsoleSection(
      {required this.title,
      required this.height,
      required this.bordered,
      required this.background,
      required this.padding});

  double height;
  bool bordered;
  String? title;
  EdgeInsetsGeometry? padding;
  Color? background;

  @override
  Widget buildWidget(BuildContext context) {
    return ConsoleSectionUI(section: this);
  }
}
