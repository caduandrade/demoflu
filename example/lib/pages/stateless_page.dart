import 'package:demoflu/demoflu.dart';
import 'package:example/pages/stateless_example.dart';

class StatelessPage extends DemoFluPage {
  StatelessPage() {
    code('lib/pages/stateless_page.dart',
        loadMode: LoadMode.readOnlyMarked, mark: 'widget');
    //@demoflu_start:widget
    widget((context) => const StatelessExample(),
        title: 'Example of a Stateless widget', maxWidth: 500);
    //@demoflu_end:widget
    code('lib/pages/stateless_example.dart', title: 'Widget source code');
  }
}
