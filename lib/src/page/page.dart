import 'package:demoflu/src/macro.dart';
import 'package:demoflu/src/page/borders/section_border.dart';
import 'package:demoflu/src/page/heading_section.dart';
import 'package:demoflu/src/page/page_section_group.dart';
import 'package:demoflu/src/page/section_collection.dart';
import 'package:demoflu/src/page/text_section.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Page to display content in page.
/// Use different methods to create page according to your needs.
abstract class DemoFluPage with SectionCollectionMixin {
  late MacroFactoryHelper _macroFactory;

  /// Initialize sections.
  void initialize(BuildContext context);

  /// Runs a  macro.
  void runMacro(dynamic id, BuildContext context) {
    _macroFactory.getPageMacro(id)(context, this);
  }

  /// Runs a group section macro.
  PageSectionGroup runGroupMacro(dynamic id, BuildContext context) {
    return _macroFactory.getGroupMacro(id)(context, this);
  }

  /// Runs a heading section macro.
  HeadingSection runHeadingMacro(dynamic id, BuildContext context) {
    return _macroFactory.getHeadingMacro(id)(context, this);
  }

  /// Runs a heading section macro.
  TextSection runTextMacro(dynamic id, BuildContext context) {
    return _macroFactory.getTextMacro(id)(context, this);
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

@internal
class DemoFluPageHelper {
  static void setMacroFactory(DemoFluPage page, MacroFactory? factory) {
    page._macroFactory = MacroFactoryHelper(factory);
  }
}
