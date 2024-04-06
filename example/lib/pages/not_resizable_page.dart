import 'package:demoflu/demoflu.dart';
import 'package:example/pages/not_resizable_example.dart';

class NotResizablePage extends DemoFluPage {
  NotResizablePage() {
    widget((context) => const NotResizableExample());
    code('lib/pages/not_resizable_example.dart');
  }
}
