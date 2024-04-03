import 'package:demoflu/demoflu.dart';
import 'package:example/pages/ignore_example.dart';

class IgnoringPage extends DemoFluPage {
  IgnoringPage() {
    sourceCodeSection('lib/pages/ignore_example.dart',
        title: 'Full source code', ignoreEnabled: false);

    sourceCodeSection('lib/pages/ignore_example.dart',
        title: 'Source code with ignored segments');

    sourceCodeSection('lib/pages/ignoring_page.dart',
        title: 'Page source code');
  }
}
