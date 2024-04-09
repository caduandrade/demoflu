import 'package:demoflu/src/internal/provider.dart';
import 'package:demoflu/src/internal/sections/widgets/clipboard_copy_widget.dart';
import 'package:demoflu/src/internal/sections/widgets/titled_widget.dart';
import 'package:demoflu/src/sections/code_section.dart';
import 'package:demoflu/src/sections_defaults.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

/// Widget for code section.
@internal
class CodeSectionUI extends StatefulWidget {
  const CodeSectionUI({Key? key, required this.section}) : super(key: key);

  final CodeSection section;

  @override
  State<StatefulWidget> createState() => CodeSectionUIState();
}

class CodeSectionUIState extends State<CodeSectionUI> {
  String? _code;
  late HighlighterTheme _theme;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant CodeSectionUI oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.section.file != oldWidget.section.file) {
      _code = null;
      _load();
    }
  }

  void _load() async {
    _theme = await HighlighterTheme.loadLightTheme();

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
    SectionDefaults defaults = DemoFluProvider.sectionDefaultsOf(context);
    Color? background = widget.section.background ?? defaults.codeBackground;
    EdgeInsetsGeometry? padding =
        widget.section.padding ?? defaults.codePadding;

    return Align(
        alignment: Alignment.centerLeft,
        child: TitledWidget(
            title: widget.section.title,
            child: ClipboardCopyWidget(
                codeSupplier: _code == null ? null : () => _code!,
                child: Container(
                    padding: padding,
                    decoration: BoxDecoration(
                        color: background,
                        border: widget.section.bordered
                            ? Border.all(color: Colors.grey[200]!, width: 1)
                            : null),
                    child: _textWidget()))));
  }

  Widget _textWidget() {
    if (_error) {
      return Center(
          child: Text('Unable to load ${widget.section.file}',
              style: TextStyle(color: Colors.red[900])));
    }
    if (_code == null) {
      return Center(child: Text('Loading...'));
    }

    Highlighter highlighter = Highlighter(
      language: 'dart',
      theme: _theme,
    );
    return SelectableText.rich(highlighter.highlight(_code!),
        style: TextStyle(fontFamily: 'code'));
  }
}
