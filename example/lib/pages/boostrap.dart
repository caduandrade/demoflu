import 'package:demoflu/demoflu.dart';

class BootstrapPage extends DemoFluPage {
  BootstrapPage() {
    titleSection('App');

    textSection()
      ..add('In order to start the application, the main method needs to')
      ..add(' instantiate an object of the DemoFluApp class and execute')
      ..add(' its run method. By doing this, the application is initialized')
      ..add(' and ready to run. This setup allows to start the application')
      ..add(' without having to create it from scratch.');

    sourceCodeSection('lib/sample_codes/empty_main.dart');

    tipBannerSection()
      ..add('Note that in the previous example, the app was initialized')
      ..add(' with an empty menu list. Further configuration is')
      ..add(' required to populate this list');

    titleSection('Menu');

    textSection()
      ..add('The menus are defined by a list of DemoMenuItem. Each')
      ..add(' DemoMenuItem can reference a page, and it can also have')
      ..add(' other child menus, thus establishing a hierarchy.');

    sourceCodeSection('lib/sample_codes/simple_main.dart');

    tipBannerSection()
      ..add('You may have noticed that this demo was created')
      ..add(' using DemoFlu itself.');

    sourceCodeSection('lib/main.dart',
        title: 'Bootstrap source code for this demo.');
  }
}
