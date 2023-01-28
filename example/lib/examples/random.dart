import 'dart:math';

import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';

class RandomWidgetExample extends Example {
  RandomWidgetExample()
      : super(
            widget: MainWidget(),
            codeFile: 'lib/examples/random.dart',
            resizable: true);
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Random random = Random();
    final Color? color =
        Colors.primaries[Random().nextInt(Colors.primaries.length)][200];
    return Container(
        child: Center(child: Text(random.nextInt(9999999).toRadixString(16))),
        color: color);
  }
}
