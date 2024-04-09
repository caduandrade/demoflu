import 'package:demoflu/src/internal/provider.dart';
import 'package:demoflu/src/sections/page_section.dart';
import 'package:demoflu/src/sections_defaults.dart';
import 'package:flutter/widgets.dart';

class SpaceSection extends PageSection {
  SpaceSection({this.height});

  double? height;

  @override
  Widget buildWidget(BuildContext context) {
    SectionDefaults defaults = DemoFluProvider.sectionDefaultsOf(context);
    double height = this.height ?? defaults.spaceHeight;
    height = height >= 0 ? height : 0;
    return SizedBox(height: height);
  }
}
