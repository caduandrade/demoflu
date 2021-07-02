import 'dart:math' as math;

import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/example.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

    if (example.codeFile != null) {
      if (state.codeVisible && state.resultVisible) {
        return MultiSplitView(
            children: [_buildCodeWidget(state), layoutBuilder],
            dividerColor: Colors.blueGrey[700]);
      } else if (state.codeVisible) {
        return _buildCodeWidget(state);
      } else if (state.resultVisible) {
        return layoutBuilder;
      }
      return Container();
    }
    return layoutBuilder;
  }

  Widget _buildCodeWidget(DemoFluAppState state) {
    return Text(state.code!);
  }
}
