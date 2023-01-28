import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';

class BarAddonExample extends AbstractExample {
  BarAddonExample()
      : super(codeFile: 'lib/examples/bar_addon.dart', resizable: true);

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

class MainWidget extends StatelessWidget {
  const MainWidget(this.count);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Count: $count'));
  }
}
