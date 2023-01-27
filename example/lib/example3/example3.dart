import 'package:demoflu/demoflu.dart';
import 'package:demoflu_example/example3/example3_widget.dart';
import 'package:flutter/material.dart';

class Example3 extends AbstractExample {
  Example3()
      : super(codeFile: 'lib/example3/example3_widget.dart', resizable: true);

  int _count = 0;

  void _incCount() {
    _count++;
    rebuildWidget();
  }

  @override
  List<Widget> buildBarWidgets(BuildContext context) =>
      [ElevatedButton(child: Text('Increment'), onPressed: () => _incCount())];

  @override
  Widget buildWidget(BuildContext context) => MainWidget(_count);

  @override
  void resetExample() {
    _count = 0;
  }
}
