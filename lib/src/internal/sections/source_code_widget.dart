import 'package:demoflu/src/internal/sections/titled_widget.dart';
import 'package:demoflu/src/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

/// Widget for code session.
@internal
class SourceCodeWidget extends StatefulWidget {
  const SourceCodeWidget({required Key key, required this.section})
      : super(key: key);

  final CodeSection section;

  @override
  State<StatefulWidget> createState() => SourceCodeWidgetState();
}

class SourceCodeWidgetState extends State<SourceCodeWidget> {
  String? _code;
  late HighlighterTheme _theme;
  bool _hover = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant SourceCodeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.section.file != oldWidget.section.file) {
      _code = null;
      _load();
    }
  }

  void _load() async {
    _theme = await HighlighterTheme.loadLightTheme();

    List<String> code;
    try {
      String fullCode = await rootBundle.loadString(widget.section.file);
      code = fullCode.split('\n');
    } catch (e) {
      setState(() {
        _error = true;
      });
      return;
    }
    String? markStart, markEnd;
    if (widget.section.mark != null) {
      markStart = '//@demoflu_start:' + widget.section.mark!;
      markEnd = '//@demoflu_end:' + widget.section.mark!;
    }
    if (widget.section.loadMode != LoadMode.readAll &&
        markStart != null &&
        markEnd != null) {
      if (widget.section.loadMode == LoadMode.readOnlyMarked) {
        code = _keepStringsBetweenStartAndEnd(
            list: code, start: markStart, end: markEnd);
      } else if (widget.section.loadMode == LoadMode.ignoreMarked) {
        code = _removeStringsBetweenStartAndEnd(
            list: code, start: markStart, end: markEnd);
      }
    }
    if (widget.section.discardMultipleEmptyLines) {
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
    if (widget.section.discardLastEmptyLine) {
      if (code.isNotEmpty && code.last.isEmpty) {
        code.removeLast();
      }
    }

    int minSpaces = _findMinSpaces(code);
    if (minSpaces > 0) {
      code = _alignStrings(code, minSpaces);
    }

    if (mounted) {
      setState(() {
        _code = code.join('\n');
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: TitledWidget(section: widget.section, child: _contentWidget()));
  }

  Widget _contentWidget() {
    if (_error) {
      return Center(
          child: Text('Unable to load ${widget.section.file}',
              style: TextStyle(color: Colors.red)));
    }
    if (_code == null) {
      return Center(child: Text('Loading...'));
    }

    return MouseRegion(
        onEnter: (event) => setState(() {
              _hover = true;
            }),
        onExit: (event) => setState(() {
              _hover = false;
            }),
        child: Stack(fit: StackFit.passthrough, children: [
          Padding(padding: EdgeInsets.all(16), child: _textWidget()),
          if (_hover)
            Positioned(child: _copyToClipboardWidget(), right: 0, top: 0)
        ]));
  }

  Widget _textWidget() {
    Highlighter highlighter = Highlighter(
      language: 'dart',
      theme: _theme,
    );
    Widget text = SelectableText.rich(highlighter.highlight(_code!),
        style: TextStyle(fontFamily: 'code'));
    if (!widget.section.wrap) {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal, child: text);
    }

    return text;
  }

  Widget _copyToClipboardWidget() {
    return Tooltip(
        message: 'Copy to clipboard',
        child: Container(
            padding: EdgeInsets.all(8),
            color: Colors.white.withOpacity(.7),
            child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _copyToClipboard(context, _code!);
                  },
                  child: const Icon(Icons.content_copy),
                ))));
  }

  Future<void> _copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Copied to clipboard'), duration: Duration(seconds: 2)));
  }
}
