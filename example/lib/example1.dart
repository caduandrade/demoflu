import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';

class Example1 extends Example {
  @override
  Widget buildMainWidget(BuildContext context) {
    return MainWidget();
  }
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(child: Text('Example 1')), color: Colors.blue);
  }
}
