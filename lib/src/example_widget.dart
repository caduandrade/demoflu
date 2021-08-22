import 'dart:math' as math;

import 'package:demoflu/src/console_widget.dart';
import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:multi_split_view/multi_split_view.dart';

class ExampleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;
    MenuItem menuItem = state.currentMenuItem!;

    Widget widget = Container();

    if (state.widgetVisible && state.consoleVisible) {
      widget = MultiSplitView(
          axis: Axis.vertical,
          children: [
            _buildExampleContentWidget(state, menuItem),
            ConsoleWidget()
          ],
          controller: state.verticalDividerController);
    } else if (state.widgetVisible) {
      widget = _buildExampleContentWidget(state, menuItem);
    } else if (state.consoleVisible) {
      widget = ConsoleWidget();
    }

    if (menuItem.codeFile != null && state.codeVisible) {
      if (state.widgetVisible || state.consoleVisible) {
        widget = MultiSplitView(
            children: [_buildCodeWidget(context, state.code!), widget],
            controller: state.horizontalDividerController);
      } else {
        widget = _buildCodeWidget(context, state.code!);
      }
    }

    return MultiSplitViewTheme(
        child: widget,
        data: MultiSplitViewThemeData(dividerColor: Colors.blueGrey[700]));
  }

  /// Builds the example content widget.
  Widget _buildExampleContentWidget(DemoFluAppState state, MenuItem menuItem) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double maxWidth = constraints.maxWidth;
      double maxHeight = constraints.maxHeight;
      Size? maxSize = state.getMaxSize(menuItem);
      if (maxSize != null) {
        maxWidth = math.min(maxWidth, maxSize.width);
        maxHeight = math.min(maxHeight, maxSize.height);
      }
      if (state.isResizable(menuItem)) {
        maxWidth = maxWidth * state.widthWeight;
        maxHeight = maxHeight * state.heightWeight;
      }
      ConstrainedBox constrainedBox = ConstrainedBox(
          child: MultiSplitViewTheme(
              child: menuItem.example!, data: MultiSplitViewThemeData()),
          constraints:
              BoxConstraints.tightFor(width: maxWidth, height: maxHeight));

      return Container(
          color: state.widgetBackground,
          child: Center(child: Container(child: constrainedBox)));
    });
  }

  /// Builds the widget for example code.
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
