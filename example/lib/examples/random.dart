import 'dart:math';

import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';

class RandomWidgetExample extends Example {
  RandomWidgetExample()
      : super(
            widget: const MainWidget(),
            codeFile: 'lib/examples/random.dart',
            resizable: true);
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    final Color? color =
        Colors.primaries[Random().nextInt(Colors.primaries.length)][200];
    return Container(
        color: color,
        child: Center(child: Text(random.nextInt(9999999).toRadixString(16))));
  }
}
