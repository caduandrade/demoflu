import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

/// Code widget.
class CodeWidget extends StatefulWidget {
  const CodeWidget({required Key key, required this.codeFile})
      : super(key: key);

  final String codeFile;

  @override
  State<StatefulWidget> createState() => CodeWidgetState();
}

class CodeWidgetState extends State<CodeWidget> {
  String? _code;

  @override
  void initState() {
    super.initState();
    _loadCode();
  }

  @override
  void didUpdateWidget(covariant CodeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.codeFile != oldWidget.codeFile) {
      _code = null;
      _loadCode();
    }
  }

  void _loadCode() async {
    String rawCode = await rootBundle.loadString(widget.codeFile);
    List<String> code = [];
    bool ignore = false;
    for (String str in rawCode.split('\n')) {
      if (str.trim() == '//@demoflu_ignore_start') {
        ignore = true;
        continue;
      } else if (str.trim() == '//@demoflu_ignore_end') {
        ignore = false;
        continue;
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
        color: Color(0xfff8f8f8),
        child: _code == null
            ? Center(child: Text('Loading...'))
            : Stack(children: [
                Positioned.fill(
                    child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: HighlightView(
                          _code!,
                          language: 'dart',
                          theme: githubTheme,
                          padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                          textStyle: TextStyle(fontSize: 16),
                        ))),
                Positioned(
                    child: IconButton(
                      icon: const Icon(Icons.content_copy),
                      tooltip: 'Copy to clipboard',
                      onPressed: () {
                        _copyToClipboard(context, _code!);
                      },
                    ),
                    right: 0,
                    top: 0)
              ]));
  }

  Future<void> _copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Copied to clipboard'), duration: Duration(seconds: 2)));
  }
}
