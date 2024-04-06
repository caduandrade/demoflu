import 'package:demoflu/demoflu.dart';
import 'package:example/pages/stateful_example.dart';

class StatefulPage extends DemoFluPage {
  StatefulPage() {
    code('lib/pages/stateful_page.dart',
        loadMode: LoadMode.readOnlyMarked, mark: 'widget');
    //@demoflu_start:widget
    widget((context) => const StatefulExample(),
        title: 'Example of a Stateful widget', maxWidth: 500);
    //@demoflu_end:widget
    code('lib/pages/stateful_example.dart', title: 'Widget source code');
  }
}
