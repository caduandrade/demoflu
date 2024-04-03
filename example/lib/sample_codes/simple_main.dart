import 'package:demoflu/demoflu.dart';
import 'package:example/sample_codes/simple_get_started_page.dart';

void main() {
  DemoFluApp(title: 'MyApp (1.0.0)', rootMenus: [_getStarted]).run();
}

DemoMenuItem get _getStarted =>
    DemoMenuItem('Get started', page: () => GetStartedPage());
