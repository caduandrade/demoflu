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
        listenable: _count).linkToSource(source: "lib/main.dart");
    sections.widget((context)=>const MyWidget());
    sections.code("lib/main.dart");
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<StatefulWidget> createState() =>MyWidgetState();

}

class MyWidgetState extends State<MyWidget> {

  @override
  void initState() {
    print('initState');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyWidget oldWidget) {
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: _inc, child: Text('$_value'));
  }

  void _inc(){
    setState(() {
      _value++;
    });
  }

}

