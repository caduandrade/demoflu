import 'package:demoflu/demoflu.dart';
import 'package:example/pages/console_example.dart';

class ConsolePage extends DemoFluPage {
  ConsolePage() {
    widgetSection((context) => const ConsoleExample(), title: 'Widget');
    consoleSection();
    sourceCodeSection('lib/pages/console_example.dart',
        title: 'Widget source code');
    sourceCodeSection('lib/pages/console_page.dart', title: 'Page source code');
  }
}
