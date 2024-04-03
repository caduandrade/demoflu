import 'package:demoflu/demoflu.dart';

class SourceCodePage extends DemoFluPage {
  SourceCodePage() {
    textSection()
      ..add('You can show any source code using the sourceCodeSection')
      ..add(' by setting the path to the source file code.');

    warningBannerSection()
      ..add('The file path needs to be specified in the')
      ..add(' assets section of the pubspec.yaml file.')
      ..add(' Remember that you can specify an entire directory')
      ..add(' instead of individual files.');

    sourceCodeSection('lib/pages/source_code_page.dart',
        title: 'Page source code');

    //TODO example with max height and horizontal scroll
  }
}
