import 'package:demoflu/src/model.dart';
import 'package:demoflu/src/page/borders/section_border.dart';
import 'package:demoflu/src/page/styled_section.dart';
import 'package:demoflu/src/provider.dart';
import 'package:demoflu/src/theme.dart';
import 'package:demoflu/src/widgets/clipboard_copy_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Section to display a source code.
class CodeSection extends StyledSection {
  CodeSection(
      {required super.title,
      required this.file,
      required this.loadMode,
      required this.mark,
      required this.discardLastEmptyLine,
      required this.discardMultipleEmptyLines,
      required super.border,
      required super.background,
      required super.padding,
      required super.marginLeft,
      required super.marginBottom,
      required super.maxWidth});

  final String file;
  LoadMode loadMode;
  String? mark;
  bool discardMultipleEmptyLines;
  bool discardLastEmptyLine;

  @override
  Widget buildContent(BuildContext context) {
    return _CodeSectionWidget(section: this);
  }

  @override
  EdgeInsetsGeometry? padding(DemoFluTheme theme) {
    return theme.codePadding ?? super.padding(theme);
  }

  @override
  SectionBorder? border(DemoFluTheme theme) {
    return theme.codeBorder ?? super.border(theme);
  }

  @override
  Color? background(DemoFluTheme theme) {
    return theme.codeBackground ?? super.background(theme);
  }

  Future<String> loadCode() async {
    List<String> code;
    String fullCode = await rootBundle.loadString(file);
    code = fullCode.split('\n');
    String? markStart, markEnd;
    if (mark != null) {
      markStart = '//@demoflu_start:' + mark!;
      markEnd = '//@demoflu_end:' + mark!;
    }
    if (loadMode != LoadMode.readAll && markStart != null && markEnd != null) {
      if (loadMode == LoadMode.readOnlyMarked) {
        code = _keepStringsBetweenStartAndEnd(
            list: code, start: markStart, end: markEnd);
      } else if (loadMode == LoadMode.ignoreMarked) {
        code = _removeStringsBetweenStartAndEnd(
            list: code, start: markStart, end: markEnd);
      }
    }
    if (discardMultipleEmptyLines) {
      int i = 0;
      while (i < code.length) {
        if (i < code.length - 2 &&
            code[i].trim().isEmpty &&
            code[i + 1].trim().isEmpty) {
          code.removeAt(i);
        } else {
          i++;
        }
      }
    }
    if (discardLastEmptyLine) {
      if (code.isNotEmpty && code.last.isEmpty) {
        code.removeLast();
      }
    }

    int minSpaces = _findMinSpaces(code);
    if (minSpaces > 0) {
      code = _alignStrings(code, minSpaces);
    }

    return code.join('\n');
  }

  int _findMinSpaces(List<String> strings) {
    int? minSpaces;
    for (String str in strings) {
      int spaces = _countLeadingSpaces(str);
      if (minSpaces == null) {
        minSpaces = spaces;
      } else if (spaces < minSpaces) {
        minSpaces = spaces;
      }
    }
    return minSpaces ?? 0;
  }

  int _countLeadingSpaces(String str) {
    int count = 0;
    for (int i = 0; i < str.length; i++) {
      if (str[i] == ' ') {
        count++;
      } else {
        break;
      }
    }
    return count;
  }

  List<String> _alignStrings(List<String> strings, int minSpaces) {
    List<String> alignedStrings = [];
    for (String str in strings) {
      if (minSpaces > 0 && str.length >= minSpaces) {
        alignedStrings.add(str.substring(minSpaces));
      } else {
        alignedStrings.add(str);
      }
    }
    return alignedStrings;
  }

  List<String> _removeStringsBetweenStartAndEnd(
      {required List<String> list,
      required String start,
      required String end}) {
    bool removing = false;
    List<String> resultList = [];
    for (var str in list) {
      if (str.trim() == start) {
        removing = true;
      } else if (str.trim() == end) {
        removing = false;
      } else if (!removing) {
        resultList.add(str);
      }
    }
    return resultList;
  }

  List<String> _keepStringsBetweenStartAndEnd(
      {required List<String> list,
      required String start,
      required String end}) {
    bool keeping = false;
    List<String> resultList = [];
    for (var str in list) {
      if (str.trim() == start) {
        keeping = true;
      } else if (str.trim() == end) {
        keeping = false;
      } else if (keeping) {
        resultList.add(str);
      }
    }
    return resultList;
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
class _CodeSectionWidget extends StatefulWidget {
  const _CodeSectionWidget({Key? key, required this.section}) : super(key: key);

  final CodeSection section;

  @override
  State<StatefulWidget> createState() => _CodeSectionWidgetState();
}

class _CodeSectionWidgetState extends State<_CodeSectionWidget> {
  String? _code;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant _CodeSectionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.section.file != oldWidget.section.file) {
      _code = null;
      _load();
    }
  }

  void _load() async {
    String code;
    try {
      code = await widget.section.loadCode();
    } catch (e) {
      setState(() {
        _error = true;
      });
      return;
    }

    if (mounted) {
      setState(() {
        _code = code;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipboardCopyWidget(
        codeSupplier: _code == null ? null : () => _code!,
        child: _textWidget(context));
  }

  Widget _textWidget(BuildContext context) {
    if (_error) {
      return Center(
          child: Text('Unable to load ${widget.section.file}',
              style: TextStyle(color: Colors.red[900])));
    }
    if (_code == null) {
      return Center(child: Text('Loading...'));
    }

    DemoFluModel model = DemoFluProvider.modelOf(context);

    return SelectableText.rich(model.highlighter.highlight(_code!),
        style: TextStyle(fontFamily: 'code'));
  }
}
