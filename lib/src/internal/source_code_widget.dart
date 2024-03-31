import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

/// Code widget.
@internal
class SourceCodeWidget extends StatefulWidget {
  const SourceCodeWidget(
      {required Key key,
      required this.file,
      required this.wrap,
      required this.ignoreEnabled})
      : super(key: key);

  final String file;
  final bool wrap;
  final bool ignoreEnabled;

  @override
  State<StatefulWidget> createState() => SourceCodeWidgetState();
}

class SourceCodeWidgetState extends State<SourceCodeWidget> {
  String? _code;
  late HighlighterTheme _theme;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant SourceCodeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.file != oldWidget.file) {
      _code = null;
      _load();
    }
  }

  void _load() async {
    _theme = await HighlighterTheme.loadLightTheme();

    String rawCode = await rootBundle.loadString(widget.file);
    List<String> code = [];
    bool ignore = false;
    for (String str in rawCode.split('\n')) {
      if (widget.ignoreEnabled) {
        if (str.trim() == '//@demoflu_ignore_start') {
          ignore = true;
          continue;
        } else if (str.trim() == '//@demoflu_ignore_end') {
          ignore = false;
          continue;
        }
      }
      if (!ignore) {
        code.add(str);
      }
    }
    setState(() {
      _code = code.join('\n');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[100], border: Border.all(color: Colors.black12)),
        child: _contentWidget());
  }

  Widget _contentWidget() {
    if (_code == null) {
      return Center(child: Text('Loading...'));
    }
    return Padding(
        padding: EdgeInsets.all(16),
        child: Stack(fit: StackFit.passthrough, children: [
          _textWidget(),
          Positioned(child: _copyToClipboardWidget(), right: 0, top: 0)
        ]));
  }

  Widget _textWidget() {
    Highlighter highlighter = Highlighter(
      language: 'dart',
      theme: _theme,
    );
    Widget text = SelectableText.rich(highlighter.highlight(_code!));
    if (!widget.wrap) {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal, child: text);
    }
    return text;
  }

  Widget _copyToClipboardWidget() {
    return IconButton(
      icon: const Icon(Icons.content_copy),
      tooltip: 'Copy to clipboard',
      onPressed: () {
        _copyToClipboard(context, _code!);
      },
    );
  }

  Future<void> _copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Copied to clipboard'), duration: Duration(seconds: 2)));
  }
}
