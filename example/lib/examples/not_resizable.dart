import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';

class NotResizableExample extends Example {
  NotResizableExample()
      : super(
            widget: const MainWidget(),
            codeFile: 'lib/examples/not_resizable.dart',
            resizable: false);
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green[200],
        child: const Center(child: Text('Not resizable')));
  }
}
