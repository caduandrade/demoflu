import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/section.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;
    List<Widget> children = [];
    for (DFSection section in state.sections) {
      double left = 8;
      if (section.name != null) {
        left += 8;
        children.add(Padding(
            child:
                Text(section.name!, style: TextStyle(color: Colors.grey[300])),
            padding: EdgeInsets.only(left: 8, right: 8, top: 8)));
      }
      for (DFExample example in section.examples) {
        children.add(InkWell(
            child: Padding(
                child:
                    Text(example.name, style: TextStyle(color: Colors.white)),
                padding: EdgeInsets.only(left: left, right: 8, top: 8)),
            onTap: () => state.updateFor(section.name, example)));
      }
    }
    return Container(
        child:
            ListView(children: children, padding: EdgeInsets.only(bottom: 8)),
        decoration: BoxDecoration(
            color: Colors.blueGrey[800],
            border: Border(
                right: BorderSide(width: 1, color: Colors.blueGrey[900]!))));
  }
}
