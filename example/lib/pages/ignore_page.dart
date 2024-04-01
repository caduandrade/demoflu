import 'package:demoflu/demoflu.dart';
import 'package:example/pages/ignore_example.dart';

class IgnorePage extends DemoFluPage {
  IgnorePage() {
    exampleSection((context) => const IgnoreExample());
    sourceCodeSection('lib/pages/ignore_page.dart', title: 'Page source code');
    sourceCodeSection('lib/pages/ignore_example.dart',
        title: 'Full example source code', ignoreEnabled: false);
    sourceCodeSection('lib/pages/ignore_example.dart',
        title: 'Ignored example source code');
  }
}
