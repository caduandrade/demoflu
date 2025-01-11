import 'package:demoflu/src/macro.dart';
import 'package:demoflu/src/model.dart';
import 'package:demoflu/src/page/borders/section_border.dart';
import 'package:demoflu/src/page/code_cache.dart';
import 'package:demoflu/src/page/styled_section.dart';
import 'package:demoflu/src/provider.dart';
import 'package:demoflu/src/theme.dart';
import 'package:demoflu/src/widgets/clipboard_copy_widget.dart';
import 'package:flutter/material.dart';

/// Section to display a source code.
class CodeSection extends StyledSection {
  CodeSection(
      {required super.title,
      required this.file,
      required this.loadMode,
      required this.mark,
      required this.discardLastEmptyLine,
      required this.discardMultipleEmptyLines,
      required this.discardMarks,
      required super.border,
      required super.background,
      required super.padding,
      required super.marginLeft,
      required super.marginBottom,
      required super.maxWidth});

  String file;
  LoadMode loadMode;
  String? mark;
  bool discardMultipleEmptyLines;
  bool discardLastEmptyLine;
  bool discardMarks;

  @override
  Widget buildContent(BuildContext context) {
    return _CodeSectionWidget(section: this);
  }

  @override
  void runMacro({required dynamic id, required BuildContext context}) {
    MacroFactory macroFactory = DemoFluProvider.macroFactoryOf(context);
    CodeMacro macro =
        MacroFactoryHelper.getMacro<CodeMacro>(id, 'Code', macroFactory);
    macro(context, this);
  }

  @override
  EdgeInsetsGeometry? getPaddingFromTheme(DemoFluTheme theme) {
    return theme.codePadding;
  }

  @override
  SectionBorder? getBorderFromTheme(DemoFluTheme theme) {
    return theme.codeBorder;
  }

  @override
  Color? getBackgroundFromTheme(DemoFluTheme theme) {
    return theme.codeBackground;
  }
}

enum LoadMode {
  /// Read all code, including marked page
  readAll,

  /// Read only the marked code
  readOnlyMarked,

  /// Ignore the marked code
  ignoreMarked
}

/// Widget for code section.
class _CodeSectionWidget extends StatelessWidget {
  const _CodeSectionWidget({Key? key, required this.section}) : super(key: key);

  final CodeSection section;

  @override
  Widget build(BuildContext context) {
    DemoFluModel model = DemoFluProvider.modelOf(context);
    CodeCache codeCache = DemoFluProvider.codeCacheOf(context);
    String rawCode = codeCache.getRawCodeFrom(file: section.file);
    String code = codeCache.process(
        rawCode: rawCode,
        loadMode: section.loadMode,
        mark: section.mark,
        discardMarks: section.discardMarks,
        discardMultipleEmptyLines: section.discardMultipleEmptyLines,
        discardLastEmptyLine: section.discardLastEmptyLine);
    return ClipboardCopyWidget(
        code: code,
        child: SelectableText.rich(model.highlighter.highlight(code),
            style: TextStyle(fontFamily: 'code')));
  }
}
