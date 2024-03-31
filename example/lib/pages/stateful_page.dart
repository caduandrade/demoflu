import 'package:demoflu/demoflu.dart';
import 'package:example/pages/stateful_example.dart';

class StatefulPage extends DemoFluPage {
  @override
  List<DemoFluPageSection> getSections() {
    return [exampleSection, sourceCodeSection];
  }

  DemoFluPageSection get exampleSection =>
      DemoFluPageSection.example(builder: (_) => const StatefulExample());

  DemoFluPageSection get sourceCodeSection =>
      DemoFluPageSection.dartCode(file: 'lib/pages/stateful_example.dart');
}
