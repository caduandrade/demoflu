import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';

void main() {
  DemoFluApp app = DemoFluApp(title: 'Example', rootMenus: _rootMenus);
  app.run();
}

List<DemoMenuItem> _rootMenus = [DemoMenuItem('My page', page: () => MyPage())];

class MyPage extends DemoFluPage {
  final ValueNotifier<int> _count = ValueNotifier(0);

  @override
  void buildSections(BuildContext context, PageSections sections) {
    sections.text(text: 'Hello');
    sections.widget((context) => ElevatedButton(
        onPressed: () => _count.value++, child: const Text('Increment')));
    sections.widget((context)=> const TextField());
    sections.widget((context) => Text('Count: ${_count.value}'),
        listenable: _count).linkToCode(source: "lib/main.dart");
  }
}


