import 'package:demoflu/src/sections/page_section.dart';
import 'package:flutter/widgets.dart';

class SpaceSection extends PageSection {
  SpaceSection({required double height}) : _height = height >= 0 ? height : 0;

  double _height;
  double get height => _height;

  @override
  Widget buildWidget(BuildContext context) {
    return SizedBox(height: height);
  }
}
