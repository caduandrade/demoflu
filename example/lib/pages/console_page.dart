import 'package:demoflu/demoflu.dart';
import 'package:example/pages/console_example.dart';

class ConsolePage extends DemoFluPage {
  ConsolePage() {
    text(text: 'It is possible to capture console output.');
    widget((context) => const ConsoleExample(), title: 'Widget', maxWidth: 300);
    console();
    code('lib/pages/console_example.dart', title: 'Widget source code');
    code('lib/pages/console_page.dart', title: 'The source code of this page');
  }
}
