import 'dart:math' as math;
import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/example.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExampleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;
    ThemeData theme = Theme.of(context);
    DFExample example = state.currentMenuItem!.example;
    Widget content = example.builder(context);

    return LayoutBuilder(
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
      content = ConstrainedBox(
          child: content,
          constraints:
              BoxConstraints.tightFor(width: maxWidth, height: maxHeight));

      return Container(
          color: Colors.grey[200],
          child: Center(
              child: Container(
                  child: content, color: theme.scaffoldBackgroundColor)));
    });
  }
}
