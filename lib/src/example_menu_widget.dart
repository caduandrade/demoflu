import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/example.dart';
import 'package:flutter/material.dart';

class ExampleMenuWidget extends StatelessWidget {
  ExampleMenuWidget(this.sectionName, this.example);

  final String? sectionName;
  final DFExample example;

  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;
    return InkWell(
        child: Text(example.name, style: TextStyle(color: Colors.white)),
        onTap: () => state.updateFor(sectionName, example));
  }
}
