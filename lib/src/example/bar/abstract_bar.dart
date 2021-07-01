import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/example.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class AbstractBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;
    String? sectionName = state.currentMenuItem!.sectionName;
    DFExample example = state.currentMenuItem!.example;
    return Container(
        child: buildContent(context, sectionName, example),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.blueGrey[100],
            border: Border(
                bottom: BorderSide(width: 1, color: Colors.blueGrey[500]!))));
  }

  Widget buildContent(
      BuildContext context, String? sectionName, DFExample example);
}
