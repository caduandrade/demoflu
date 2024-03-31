import 'package:demoflu/demoflu.dart';
import 'package:example/pages/not_resizable_example.dart';

class NotResizablePage extends DemoFluPage {

  @override
  List<DemoFluPageSection> getSections() {
    return [exampleSection, sourceCodeSection];
  }

  DemoFluPageSection get exampleSection =>
      DemoFluPageSection.example(builder: (_) =>  const NotResizableExample());

  DemoFluPageSection get sourceCodeSection =>
      DemoFluPageSection.dartCode(file: 'lib/pages/not_resizable_example.dart');
}
