import 'package:demoflu/src/internal/sections/console_widget.dart';
import 'package:demoflu/src/sections/titled_page_section.dart';
import 'package:flutter/src/widgets/framework.dart';

/// Session to display a console output.
class ConsoleSection extends TitledPageSection {
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
    return ConsoleWidget(section: this);
  }
}
