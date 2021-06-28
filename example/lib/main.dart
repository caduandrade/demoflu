import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DemoFluApp(
      title: 'Example Demo',
      menu: DemoFluMenu(sections: [
        DemoFluMenuSection(menuItems: [
          DemoFluMenuItem(
              text: 'Menu 1',
              builder: (context) => Center(child: Text('Text 1')),
              resizableContent: true),
          DemoFluMenuItem(
              text: 'Menu 2',
              builder: (context) => Center(child: Text('Text 2')))
        ])
      ])));
}
