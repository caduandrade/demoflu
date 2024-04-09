import 'package:demoflu/src/internal/sections/code_section_ui.dart';
import 'package:demoflu/src/sections/titled_page_section.dart';
import 'package:flutter/material.dart';

/// Session to display a source code.
class CodeSection extends TitledPageSection {
  CodeSection(
      {required super.title,
      required this.file,
      required this.wrap,
      required this.loadMode,
      required this.mark,
      required this.discardLastEmptyLine,
      required this.discardMultipleEmptyLines,
      bool bordered = true,
      Color? background,
      required super.padding})
      : super(
            minWidth: 0.0,
            maxWidth: double.infinity,
            minHeight: 0.0,
            maxHeight: double.infinity,
            bordered: bordered,
            background: background ?? Colors.grey[100]!);

  final String file;
  bool wrap;
  LoadMode loadMode;
  String? mark;
  bool discardMultipleEmptyLines;
  bool discardLastEmptyLine;

  @override
  Widget buildWidget(BuildContext context) {
    return CodeSectionUI(section: this);
  }
}

enum LoadMode {
  /// Read all code, including marked sections
  readAll,

  /// Read only the marked code
  readOnlyMarked,

  /// Ignore the marked code
  ignoreMarked
}
