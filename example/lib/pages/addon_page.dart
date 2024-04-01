import 'package:demoflu/demoflu.dart';
import 'package:example/pages/addon_example.dart';
import 'package:flutter/material.dart';

class AddonPage extends DemoFluPage {
  AddonPage() {
    exampleSection((context) => ElevatedButton(
        child: const Text('Increment'), onPressed: () => _count.value++));

    exampleSection((context) => AddonExample(_count.value), listenable: _count);

    sourceCodeSection('lib/pages/addon_example.dart',
        title: 'Example source code');

    sourceCodeSection('lib/pages/addon_page.dart', title: 'Page source code');
  }

  final ValueNotifier<int> _count = ValueNotifier<int>(0);
}
