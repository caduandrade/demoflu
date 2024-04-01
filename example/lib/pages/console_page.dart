import 'package:demoflu/demoflu.dart';
import 'package:example/pages/console_example.dart';

class ConsolePage extends DemoFluPage {
  ConsolePage() {
    exampleSection((context) => const ConsoleExample());
    consoleSection();
    sourceCodeSection('lib/pages/console_example.dart');
  }
}
