import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/section.dart';
import 'package:demoflu/src/section_menu_widget.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;
    List<Widget> children = [];
    for (DFSection section in state.sections) {
      children.add(SectionMenuWidget(section));
    }
    return Container(
        child: SingleChildScrollView(
            padding: EdgeInsets.all(8), child: Column(children: children)),
        decoration: BoxDecoration(
            color: Colors.blueGrey[800],
            border: Border(
                right: BorderSide(width: 1, color: Colors.blueGrey[900]!))));
  }
}
