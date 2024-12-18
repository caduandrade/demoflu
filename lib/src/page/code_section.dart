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

  Future<String> _load(BuildContext context) async {
    CodeCache codeCache = DemoFluProvider.codeCacheOf(context);
    return codeCache.load(
        file: section.file,
        loadMode: section.loadMode,
        mark: section.mark,
        discardMarks: section.discardMarks,
        discardMultipleEmptyLines: section.discardMultipleEmptyLines,
        discardLastEmptyLine: section.discardLastEmptyLine);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _load(context), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            String code = snapshot.data!;
            DemoFluModel model = DemoFluProvider.modelOf(context);
            return ClipboardCopyWidget(
                codeSupplier: () => code,
                child: SelectableText.rich(model.highlighter.highlight(code),
                    style: TextStyle(fontFamily: 'code')));
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Unable to load ${section.file}',
                    style: TextStyle(color: Colors.red[900])));
          }
          return Center(child: Text('Loading...'));
        });
  }
}
