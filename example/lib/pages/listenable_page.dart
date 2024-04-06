import 'package:demoflu/demoflu.dart';
import 'package:example/pages/listenable_example.dart';
import 'package:flutter/material.dart';

class ListenablePage extends DemoFluPage {
  ListenablePage() {
    text(text: 'Example of a listenable value to rebuild the widget.');

    widget((context) => _incrementButton, bordered: false);

    widget((context) => ListenableExample(_count.value),
        listenable: _count, title: 'Widget', maxWidth: 300);

    code('lib/pages/listenable_example.dart', title: 'Widget source code');

    code('lib/pages/listenable_page.dart',
        title: 'The source code of this page');
  }

  final ValueNotifier<int> _count = ValueNotifier<int>(0);

  Widget get _incrementButton => ElevatedButton(
      child: const Text('Increment the count'),
      onPressed: () => _count.value++);
}
