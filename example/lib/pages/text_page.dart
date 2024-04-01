import 'package:demoflu/demoflu.dart';
import 'package:example/pages/text_example.dart';

class TextPage extends DemoFluPage {
  TextPage(this.name) {
    exampleSection((context) => TextExample(name: name));
    sourceCodeSection('lib/pages/text_example.dart');
  }

  final String name;
}
