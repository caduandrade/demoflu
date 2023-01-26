import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

class CodeWidget extends StatelessWidget {
  const CodeWidget({required this.code});

  final String code;

  Widget build(BuildContext context) {
    return Container(
        color: Color(0xfff8f8f8),
        child: Stack(children: [
          Positioned.fill(
              child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: HighlightView(
                    code,
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
                  _copyToClipboard(context, code);
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
