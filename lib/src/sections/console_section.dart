import 'package:demoflu/src/internal/sections/console_section_ui.dart';
import 'package:demoflu/src/sections/container_section.dart';
import 'package:flutter/src/widgets/framework.dart';

/// Section to display a console output.
class ConsoleSection extends ContainerSection {
  ConsoleSection(
      {required super.title,
      required this.height,
      required super.bordered,
      required super.background,
      required super.padding})
      : super(
            minWidth: 0.0,
            maxWidth: double.infinity,
            minHeight: height,
            maxHeight: height);

  double height;

  @override
  Widget buildWidget(BuildContext context) {
    return ConsoleSectionUI(section: this);
  }
}
