import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';

class NotResizableExample extends Example {
  NotResizableExample()
      : super(
            widget: MainWidget(),
            codeFile: 'lib/examples/not_resizable.dart',
            resizable: false);
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(child: Text('Not resizable')), color: Colors.green[200]);
  }
}
