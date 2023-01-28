import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';

class StatefulExample extends Example {
  StatefulExample()
      : super(codeFile: 'lib/examples/stateful.dart', widget: MainWidget());
}

class MainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: TextButton(
                child: Text('Tap here: $count'),
                onPressed: () => setState(() {
                      count++;
                    }))),
        color: Colors.yellow[200]);
  }
}
