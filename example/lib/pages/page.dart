import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';

class Page extends DemoFluPage {
  Page() {
    textSection()
      ..add('To create a page, you simply need to have a class')
      ..add(' extending DemoFluPage.');

    textSection()
      ..add('Sections are created using specialized methods,')
      ..add(' which should be invoked within the constructor.');

    sourceCodeSection('lib/pages/page.dart', title: 'Page source code');
  }
}
