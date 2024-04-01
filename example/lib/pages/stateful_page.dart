import 'package:demoflu/demoflu.dart';
import 'package:example/pages/stateful_example.dart';

class StatefulPage extends DemoFluPage {
  StatefulPage() {
    exampleSection((context) => const StatefulExample());
    sourceCodeSection('lib/pages/stateful_example.dart');
  }
}
