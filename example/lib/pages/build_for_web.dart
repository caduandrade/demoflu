import 'package:demoflu/demoflu.dart';

class BuildForWeb extends DemoFluPage {
  BuildForWeb() {
    code('lib/pages/build_for_web.txt', title: 'Build the demo app');

    tipBanner(text: 'Use --base-href if necessary');
  }
}
