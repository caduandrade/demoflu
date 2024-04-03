import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';

class TextPage extends DemoFluPage {
  TextPage() {
    textSection(text: 'You can add texts using the textSection method.');

    textSection(icon: Icons.check, text: 'The text can start with an icon.');

    //TODO adicionar cores , spans...

    sourceCodeSection('lib/pages/text_page.dart', title: 'Page source code');
  }
}
