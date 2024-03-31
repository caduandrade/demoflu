import 'package:demoflu/demoflu.dart';
import 'package:example/pages/ignore_example.dart';

class IgnorePage extends DemoFluPage {
  @override
  List<DemoFluPageSection> getSections() {
    return [
      exampleSection,
      exampleSourceCodeSection,
      exampleIgnoredSourceCodeSection,
      pageSourceCodeSection
    ];
  }

  DemoFluPageSection get exampleSection =>
      DemoFluPageSection.example(builder: (_) => const IgnoreExample());

  DemoFluPageSection get pageSourceCodeSection => DemoFluPageSection.dartCode(
      title: 'Page source code', file: 'lib/pages/ignore_page.dart');

  DemoFluPageSection get exampleSourceCodeSection =>
      DemoFluPageSection.dartCode(
          title: 'Full example source code',
          file: 'lib/pages/ignore_example.dart',
          ignoreEnabled: false);

  DemoFluPageSection get exampleIgnoredSourceCodeSection =>
      DemoFluPageSection.dartCode(
          title: 'Ignored example source code',
          file: 'lib/pages/ignore_example.dart');
}
