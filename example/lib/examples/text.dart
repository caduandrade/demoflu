import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';

class TextWidgetExample extends Example {
  TextWidgetExample(String name)
      : super(
            widget: MainWidget(name: name),
            codeFile: 'lib/examples/text.dart',
            resizable: true);
}

class MainWidget extends StatelessWidget {
  const MainWidget({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(32),
        child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
                color: Colors.blue[100],
                border: Border.all(color: Colors.black)),
            child: Center(child: Text(name))));
  }
}
