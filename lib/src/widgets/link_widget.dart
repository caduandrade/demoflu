import 'package:demoflu/demoflu.dart';
import 'package:demoflu/src/link.dart';
import 'package:demoflu/src/model.dart';
import 'package:demoflu/src/page/code_cache.dart';
import 'package:demoflu/src/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LinkWidget extends StatelessWidget {
  const LinkWidget({super.key, required this.link});

  final DemoFluLink link;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [_header(context), Expanded(child: _body(context))]);
  }

  Widget _header(BuildContext context) {
    DemoFluTheme theme = DemoFluProvider.themeOf(context);
    return Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: theme.appBackground,
            border: Border(
                bottom: BorderSide(color: theme.dividerColor, width: 1))),
        child: Row(
            children: [_backButton(context), _title(), _copyButton(context)]));
  }

  Widget _title() {
    return Text("Source code");
  }

  Widget _backButton(BuildContext context) {
    DemoFluModel model = DemoFluProvider.modelOf(context);
    return IconButton(
        onPressed: () => model.link = null,
        icon: Icon(Icons.arrow_back, color: Colors.blue));
  }

  Widget _copyButton(BuildContext context) {
    return IconButton(
        onPressed: () => _copyToClipboard(context),
        icon: Icon(Icons.content_copy, color: Colors.blue));
  }

  Future<void> _copyToClipboard(BuildContext context) async {
    CodeCache codeCache = DemoFluProvider.codeCacheOf(context);
    String rawCode = codeCache.getRawCodeFrom(file: link.file);
    String code = codeCache.process(
        rawCode: rawCode,
        loadMode: LoadMode.readAll,
        mark: null,
        discardMarks: true,
        discardMultipleEmptyLines: true,
        discardLastEmptyLine: true);
    await Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Copied to clipboard'), duration: Duration(seconds: 2)));
  }

  Widget _body(BuildContext context) {
    DemoFluModel model = DemoFluProvider.modelOf(context);
    DemoFluTheme theme = DemoFluProvider.themeOf(context);
    CodeCache codeCache = DemoFluProvider.codeCacheOf(context);
    String rawCode = codeCache.getRawCodeFrom(file: link.file);
    String code = codeCache.process(
        rawCode: rawCode,
        loadMode: LoadMode.readAll,
        mark: null,
        discardMarks: true,
        discardMultipleEmptyLines: true,
        discardLastEmptyLine: true);

    return Container(
        color: theme.codeBackground,
        padding: theme.codePadding,
        child: SelectableText.rich(model.highlighter.highlight(code),
            style: TextStyle(fontFamily: 'code')));
  }
}
