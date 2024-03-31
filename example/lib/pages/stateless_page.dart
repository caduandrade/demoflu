import 'package:demoflu/demoflu.dart';
import 'package:example/pages/stateless_example.dart';

class StatelessPage extends DemoFluPage {
  @override
  List<DemoFluPageSection> getSections() {
    return [exampleSection, sourceCodeSection];
  }

  DemoFluPageSection get exampleSection =>
      DemoFluPageSection.example(builder: (_) => const StatelessExample());

  DemoFluPageSection get sourceCodeSection =>
      DemoFluPageSection.dartCode(file: 'lib/pages/stateless_example.dart');
}
