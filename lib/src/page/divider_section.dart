import 'package:demoflu/src/page/page_section.dart';
import 'package:flutter/material.dart';

/// Section to display a divider.
class DividerSection extends PageSection {
  DividerSection(
      {required super.marginLeft,
      required super.marginBottom,
      required super.maxWidth});

  @override
  Widget buildContent(BuildContext context) {
    return Divider(height: 1, color: Colors.grey[300], thickness: 1);
  }
}
