import 'package:demoflu/src/sections/page_section.dart';
import 'package:flutter/material.dart';

/// Session to display a divider.
class DividerSection extends PageSection {
  @override
  Widget buildWidget(BuildContext context) {
    return Divider(height: 1, color: Colors.grey[300], thickness: 1);
  }
}
