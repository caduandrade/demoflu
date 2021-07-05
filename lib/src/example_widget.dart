import 'dart:math' as math;

import 'package:demoflu/src/console_widget.dart';
import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/example.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:multi_split_view/multi_split_view.dart';

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({Key? key, required this.buttonClickNotifier})
      : super(key: key);

  final ButtonClickNotifier buttonClickNotifier;

  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;
    Example example = state.currentExample!;
    return _build(context, state, example);
  }

  Widget _build(BuildContext context, DemoFluAppState state, Example example) {
    Widget content = example.builder(buttonClickNotifier);
    LayoutBuilder layoutBuilder = LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double maxWidth = constraints.maxWidth;
      double maxHeight = constraints.maxHeight;
      Size? maxSize = state.getMaxSize(example);
      if (maxSize != null) {
        maxWidth = math.min(maxWidth, maxSize.width);
        maxHeight = math.min(maxHeight, maxSize.height);
      }
      if (state.isResizable(example)) {
        maxWidth = maxWidth * state.widthWeight;
        maxHeight = maxHeight * state.heightWeight;
      }
      ConstrainedBox constrainedBox = ConstrainedBox(
          child: content,
          constraints:
              BoxConstraints.tightFor(width: maxWidth, height: maxHeight));

      return Container(
          color: state.widgetBackground,
          child: Center(child: Container(child: constrainedBox)));
    });

    Widget? widgetAndOrConsole;
    if (state.widgetVisible && state.consoleVisible) {
      widgetAndOrConsole = MultiSplitView(
          axis: Axis.vertical,
          children: [layoutBuilder, ConsoleWidget()],
          dividerColor: Colors.blueGrey[700],
          controller: state.verticalDividerController);
    } else if (state.widgetVisible) {
      widgetAndOrConsole = layoutBuilder;
    } else if (state.consoleVisible) {
      widgetAndOrConsole = ConsoleWidget();
    }

    if (example.codeFile != null && state.codeVisible) {
      if (widgetAndOrConsole != null) {
        return MultiSplitView(
            children: [
              _buildCodeWidget(context, state.code!),
              widgetAndOrConsole
            ],
            dividerColor: Colors.blueGrey[700],
            controller: state.horizontalDividerController);
      } else {
        return _buildCodeWidget(context, state.code!);
      }
    } else if (widgetAndOrConsole != null) {
      return widgetAndOrConsole;
    }
    return Container();
  }

  Widget _buildCodeWidget(BuildContext context, String code) {
    return Container(
        color: Color(0xfff8f8f8),
        child: Stack(children: [
          SingleChildScrollView(
              child: HighlightView(
            code,
            language: 'dart',
            theme: githubTheme,
            padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
            textStyle: TextStyle(fontSize: 16),
          )),
          Positioned(
              child: IconButton(
                icon: const Icon(Icons.content_copy),
                tooltip: 'Copy to clipboard',
                onPressed: () {
                  copyToClipboard(context, code);
                },
              ),
              right: 0,
              top: 0)
        ]));
  }

  Future<void> copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Copied to clipboard'), duration: Duration(seconds: 2)));
  }
}
