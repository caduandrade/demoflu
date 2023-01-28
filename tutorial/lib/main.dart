import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:tutorial/examples/stateless.dart';

void main() {
  runApp(DemoFluApp(title: 'Tutorial', menuItems: [
    DemoMenuItem(name: 'Section'),
    DemoMenuItem(name: 'Stateless', example: StatelessExample(), indent: 2)
  ]));
}

void alternativeMain() {
  runApp(DemoFluApp(title: 'Tutorial', menuItems: _menuItems()));
}

List<DemoMenuItem> _menuItems() {
  var builder = DemoMenuItem.builder();
  builder
    ..indent(1)
    ..add('Section')
    ..indent(2)
    ..add('Stateless', example: StatelessExample());
  return builder.menuItems;
}
