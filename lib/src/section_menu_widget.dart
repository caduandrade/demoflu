import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/example_menu_widget.dart';
import 'package:demoflu/src/section.dart';
import 'package:flutter/material.dart';

class SectionMenuWidget extends StatelessWidget {
  SectionMenuWidget(this.section);

  final DFSection section;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (DFExample example in section.examples) {
      children.add(ExampleMenuWidget(section.name, example));
    }
    return Column(children: children);
  }
}
