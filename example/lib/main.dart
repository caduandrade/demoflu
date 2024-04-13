import 'package:demoflu/demoflu.dart';
import 'package:flutter/widgets.dart';

void main() {
  DemoFluApp app = DemoFluApp(title: 'Example', rootMenus: _rootMenus);
  app.run();
}

List<DemoMenuItem> _rootMenus = [DemoMenuItem('My page', page: () => MyPage())];

class MyPage extends DemoFluPage {
  @override
  void initialize(BuildContext context) {
    text(text: 'Hello');
  }
}
