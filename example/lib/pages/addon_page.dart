import 'package:demoflu/demoflu.dart';
import 'package:example/pages/addon_example.dart';
import 'package:flutter/material.dart';

class AddonPage extends DemoFluPage {
  final ValueNotifier<int> _count = ValueNotifier<int>(0);

  @override
  List<DemoFluPageSection> getSections() {
    return [test, exampleSection, sourceCodeSection, pageSourceCodeSection];
  }

  DemoFluPageSection get test => DemoFluPageSection.example(
      builder: (_) => ElevatedButton(
          child: const Text('Increment'), onPressed: () => _count.value++));

  //TODO listener to rebuild
  DemoFluPageSection get exampleSection => DemoFluPageSection.example(
      listenable: _count, builder: (_) => AddonExample(_count.value));

  DemoFluPageSection get sourceCodeSection => DemoFluPageSection.dartCode(
      title: 'Example source code', file: 'lib/pages/addon_example.dart');

  DemoFluPageSection get pageSourceCodeSection => DemoFluPageSection.dartCode(
      title: 'Page source code', file: 'lib/pages/addon_page.dart');

  List<Widget> buildBarWidgets(BuildContext context) => [
        ElevatedButton(
            child: const Text('Increment'), onPressed: () => _count.value++)
      ];
}
