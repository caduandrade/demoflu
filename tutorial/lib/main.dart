import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:tutorial/examples/stateless.dart';

void main() {
  runApp(DemoFluApp(title: 'Tutorial', menuRoots: [
    DemoMenuItem(name: 'Section', children: [
      DemoMenuItem(name: 'Stateless', example: StatelessExample())
    ])
  ]));
}
