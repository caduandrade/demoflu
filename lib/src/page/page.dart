import 'package:demoflu/demoflu.dart';
import 'package:demoflu/src/macro.dart';
import 'package:demoflu/src/page/section_collection.dart';
import 'package:demoflu/src/provider.dart';
import 'package:flutter/material.dart';

/// Page to display content in page.
/// Use different methods to create page according to your needs.
abstract class DemoFluPage with SectionCollectionMixin {
  /// Initialize sections.
  void initialize(BuildContext context);

  /// Runs a  macro.
  void runMacro({required dynamic id, required BuildContext context}) {
    MacroFactory macroFactory = DemoFluProvider.macroFactoryOf(context);
    PageMacro macro =
        MacroFactoryHelper.getMacro<PageMacro>(id, 'Page', macroFactory);
    macro(context, this);
  }

  /// Creates a group of sections.
  PageSectionGroup group(
      {double? marginLeft,
      double? marginBottom,
      EdgeInsetsGeometry? padding,
      Color? background,
      SectionBorder? border,
      double maxWidth = double.infinity,
      String? title}) {
    PageSectionGroup group = PageSectionGroup(
        title: title,
        marginLeft: marginLeft,
        marginBottom: marginBottom,
        padding: padding,
        background: background,
        border: border,
        maxWidth: maxWidth);
    SectionCollectionHelper.addSectionOn(group, this);
    return group;
  }
}
