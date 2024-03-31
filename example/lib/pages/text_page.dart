import 'package:demoflu/demoflu.dart';
import 'package:example/pages/text_example.dart';

class TextPage extends DemoFluPage {
  const TextPage(this.name);

  final String name;

  @override
  List<DemoFluPageSection> getSections() {
    return [exampleSection, sourceCodeSection];
  }

  DemoFluPageSection get exampleSection =>
      DemoFluPageSection.example(builder: (_) => TextExample(name: name));

  DemoFluPageSection get sourceCodeSection =>
      DemoFluPageSection.dartCode(file: 'lib/pages/text_example.dart');
}
