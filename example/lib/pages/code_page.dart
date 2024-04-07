import 'package:demoflu/demoflu.dart';

class CodePage extends DemoFluPage {
  CodePage() {
    text()
      ..add('You can show any source code using the code section method')
      ..add(' by setting the path to the source file code.');

    code('lib/samples/simple_code_page.dart', title: 'Example');

    warningBanner()
      ..add('The file path needs to be in the assets section of the')
      ..add(' pubspec.yaml file. Remember that you can specify an')
      ..add(' entire directory instead of individual files.');

    code('lib/samples/assets.txt', title: 'Assets example in pubspec.yaml');

    title('Font');

    text()
      ..add('The expected font family name for the code section is "code".')
      ..add(' It is possible to define a font for this section')
      ..add(' in the pubspec.yaml if desired.');

    code('lib/samples/fonts.txt', title: 'Example of a monospaced font');
  }
}
