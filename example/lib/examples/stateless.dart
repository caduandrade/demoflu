import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';

class StatelessExample extends Example {
  StatelessExample()
      : super(
            widget: MainWidget(),
            codeFile: 'lib/examples/stateless.dart',
            resizable: true);
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(child: Text('Stateless')), color: Colors.blue[200]);
  }
}
