import 'package:demoflu/demoflu.dart';
import 'package:example/pages/stateless_example.dart';

class StatelessPage extends DemoFluPage {
  StatelessPage() {
    //TODO title?
    widgetSection((context) => const StatelessExample(),
        title: 'Example of a Stateless widget');
    sourceCodeSection('lib/pages/stateless_example.dart',
        title: 'Widget source code');
    sourceCodeSection('lib/pages/stateless_page.dart',
        title: 'Page source code');
  }
}
