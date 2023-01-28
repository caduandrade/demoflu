import 'package:demoflu/demoflu.dart';
import 'package:demoflu_example/examples/bar_addon.dart';
import 'package:demoflu_example/examples/console.dart';
import 'package:demoflu_example/examples/random.dart';
import 'package:demoflu_example/examples/not_resizable.dart';
import 'package:demoflu_example/examples/stateful.dart';
import 'package:demoflu_example/examples/stateless.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DemoFluApp(heightWeight: .5, title: 'Example Demo', menuRoots: [
    DemoMenuItem(name: 'Section', children: [
      DemoMenuItem(name: 'Stateless', example: Stateless()),
      DemoMenuItem(name: 'Stateful', example: StatefulExample()),
      DemoMenuItem(name: 'Console', example: Console()),
      DemoMenuItem(name: 'Bar addon', example: BarAddonExample()),
      DemoMenuItem(name: 'Not resizable', example: NotResizable())
    ]),
    DemoMenuItem(name: 'Nested sections', children: [
      DemoMenuItem(
          name: 'Section with example',
          example: RandomWidget(),
          children: [
            DemoMenuItem(name: 'Leaf 1', example: RandomWidget()),
            DemoMenuItem(name: 'Leaf 2', example: RandomWidget())
          ]),
      DemoMenuItem(name: 'Section', example: RandomWidget(), children: [
        DemoMenuItem(name: 'Leaf 3', example: RandomWidget()),
        DemoMenuItem(name: 'Leaf 4', example: RandomWidget())
      ])
    ])
  ]));
}
