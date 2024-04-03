import 'package:demoflu/demoflu.dart';
import 'package:example/pages/stateful_example.dart';

class StatefulPage extends DemoFluPage {
  StatefulPage() {
    //TODO title?
    widgetSection((context) => const StatefulExample(),
        title: 'Example of a Stateful widget');
    sourceCodeSection('lib/pages/stateful_example.dart',
        title: 'Widget source code');
    sourceCodeSection('lib/pages/stateful_page.dart',
        title: 'Page source code');
  }
}
