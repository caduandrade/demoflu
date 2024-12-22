import 'package:demoflu/src/page/page_sections.dart';
import 'package:flutter/material.dart';

/// Page to display content in page.
/// Use different methods to create page according to your needs.
abstract class DemoFluPage {
  /// Builds the page sections.
  void buildSections(BuildContext context, PageSections sections);
}
