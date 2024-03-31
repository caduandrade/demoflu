import 'package:demoflu/demoflu.dart';
import 'package:example/pages/console_example.dart';

class ConsolePage extends DemoFluPage {
  @override
  List<DemoFluPageSection> getSections() {
    return [exampleSection, consoleSection, sourceCodeSection];
  }

  DemoFluPageSection get exampleSection =>
      DemoFluPageSection.example(builder: (_) => const ConsoleExample());

  DemoFluPageSection get consoleSection => DemoFluPageSection.console();

  DemoFluPageSection get sourceCodeSection =>
      DemoFluPageSection.dartCode(file: 'lib/pages/console_example.dart');
}
