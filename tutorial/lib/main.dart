import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:tutorial/examples/stateless.dart';

void main() {
  runApp(DemoFluApp(title: 'Tutorial', menuItems: [
    DemoMenuItem(name: 'Section'),
    DemoMenuItem(name: 'Stateless', example: StatelessExample(), indent: 2)
  ]));
}
