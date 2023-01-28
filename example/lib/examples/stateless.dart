import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';

class StatelessExample extends Example {
  StatelessExample()
      : super(
            widget: const MainWidget(),
            codeFile: 'lib/examples/stateless.dart',
            resizable: true);
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue[200], child: const Center(child: Text('Stateless')));
  }
}
