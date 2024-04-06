import 'package:demoflu/demoflu.dart';

class Page extends DemoFluPage {
  Page() {
    text(text: 'This is where you can demonstrate your package.');

    text()
      ..add('To create a page, you simply need to have a class')
      ..add(' extending DemoFluPage.');

    text()
      ..add('Sections are created using specialized methods,')
      ..add(' which should be invoked within the constructor.');

    code('lib/samples/empty_page.dart', title: 'Example');
  }
}
