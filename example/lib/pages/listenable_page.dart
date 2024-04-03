import 'package:demoflu/demoflu.dart';
import 'package:example/pages/listenable_example.dart';
import 'package:flutter/material.dart';

class ListenablePage extends DemoFluPage {
  ListenablePage() {
    //TODO text
    textSection(text: 'Example of a Listenable to rebuild the widget.');

    widgetSection((context) => _incrementButton, bordered: false);

    widgetSection((context) => ListenableExample(_count.value),
        listenable: _count, title: 'Widget');

    sourceCodeSection('lib/pages/listenable_example.dart',
        title: 'Widget source code');

    sourceCodeSection('lib/pages/listenable_page.dart',
        title: 'Page source code');
  }

  final ValueNotifier<int> _count = ValueNotifier<int>(0);

  Widget get _incrementButton => ElevatedButton(
      child: const Text('Increment the count'),
      onPressed: () => _count.value++);
}
