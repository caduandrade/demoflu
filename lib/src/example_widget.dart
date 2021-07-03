import 'dart:math' as math;

import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/example.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:multi_split_view/multi_split_view.dart';

class ExampleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;
    DFExample example = state.currentMenuItem!.example;
    return _build(context, state, example);
  }

  Widget _build(
      BuildContext context, DemoFluAppState state, DFExample example) {
    ThemeData theme = Theme.of(context);
    Widget content = example.builder(context);
    LayoutBuilder layoutBuilder = LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double maxWidth = constraints.maxWidth;
      double maxHeight = constraints.maxHeight;
      if (example.maxSize != null) {
        maxWidth = math.min(maxWidth, example.maxSize!.width);
        maxHeight = math.min(maxHeight, example.maxSize!.height);
      }
      if (example.resizable) {
        maxWidth = maxWidth * state.widthWeight;
        maxHeight = maxHeight * state.heightWeight;
      }
      ConstrainedBox constrainedBox = ConstrainedBox(
          child: content,
          constraints:
              BoxConstraints.tightFor(width: maxWidth, height: maxHeight));

      return Container(
          color: Colors.grey[200],
          child: Center(
              child: Container(
                  child: constrainedBox,
                  color: theme.scaffoldBackgroundColor)));
    });

    Widget? widgetAndOrConsole;
    if (state.widgetVisible && state.consoleVisible) {
      widgetAndOrConsole = MultiSplitView(
          axis: Axis.vertical,
          children: [layoutBuilder, _buildConsoleWidget(state)],
          dividerColor: Colors.blueGrey[700],
          controller: MultiSplitViewController(weights: [.9, .1]));
    } else if (state.widgetVisible) {
      widgetAndOrConsole = layoutBuilder;
    } else if (state.consoleVisible) {
      widgetAndOrConsole = _buildConsoleWidget(state);
    }

    if (example.codeFile != null && state.codeVisible) {
      if (widgetAndOrConsole != null) {
        return MultiSplitView(
            children: [_buildCodeWidget(state), widgetAndOrConsole],
            dividerColor: Colors.blueGrey[700],
            controller: MultiSplitViewController(weights: [.5, .5]));
      } else {
        return _buildCodeWidget(state);
      }
    } else if (widgetAndOrConsole != null) {
      return widgetAndOrConsole;
    }
    return Container();
  }

  Widget _buildCodeWidget(DemoFluAppState state) {
    return Container(
        color: Color(0xfff8f8f8),
        child: SingleChildScrollView(
            child: HighlightView(
          state.code!,
          language: 'dart',
          theme: githubTheme,
          padding: EdgeInsets.all(16),
          textStyle: TextStyle(fontSize: 16),
        )));
  }

  Widget _buildConsoleWidget(DemoFluAppState state) {
    return SingleChildScrollView(
        child: Text(state.console), padding: EdgeInsets.all(16));
  }
}
