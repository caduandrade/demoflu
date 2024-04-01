import 'package:demoflu/demoflu.dart';
import 'package:example/pages/stateless_example.dart';

class StatelessPage extends DemoFluPage {
  StatelessPage() {
    exampleSection((context) => const StatelessExample());
    sourceCodeSection('lib/pages/stateless_example.dart');
  }
}
