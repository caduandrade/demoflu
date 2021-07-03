import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Example2 extends StatefulWidget {
  @override
  Example2State createState() => Example2State();
}

class Example2State extends DemoState<Example2> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            onPressed: () {
              demoConsole('hi!');
            },
            child: Text('Text 2')));
  }
}
