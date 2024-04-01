import 'package:demoflu/demoflu.dart';
import 'package:example/pages/not_resizable_example.dart';

class NotResizablePage extends DemoFluPage {
  NotResizablePage() {
    exampleSection((context) => const NotResizableExample());
    sourceCodeSection('lib/pages/not_resizable_example.dart');
  }
}
