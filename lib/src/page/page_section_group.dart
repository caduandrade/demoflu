import 'package:demoflu/src/macro.dart';
import 'package:demoflu/src/page/section_collection.dart';
import 'package:demoflu/src/page/styled_section.dart';
import 'package:demoflu/src/provider.dart';
import 'package:demoflu/src/widgets/section_collection_widget.dart';
import 'package:flutter/widgets.dart';

class PageSectionGroup extends StyledSection with SectionCollectionMixin {
  PageSectionGroup(
      {required super.marginLeft,
      required super.marginBottom,
      required super.maxWidth,
      required super.padding,
      required super.background,
      required super.border,
      required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return SectionCollectionWidget(collection: this);
  }

  @override
  void runMacro({required dynamic id, required BuildContext context}) {
    MacroFactory macroFactory = DemoFluProvider.macroFactoryOf(context);
    GroupMacro macro =
        MacroFactoryHelper.getMacro<GroupMacro>(id, 'Group', macroFactory);
    macro(context, this);
  }
}
