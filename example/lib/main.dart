import 'package:demoflu/demoflu.dart';

void main() {
  DemoFluApp(title: 'Example', rootMenus: [_getStarted]).run();
}

DemoMenuItem get _getStarted =>
    DemoMenuItem('Get started', page: () => GetStartedPage());

class GetStartedPage extends DemoFluPage {
  GetStartedPage() {
    text(text: 'Hello');
  }
}
