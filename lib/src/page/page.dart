import 'package:demoflu/demoflu.dart';
import 'package:demoflu/src/macro.dart';
import 'package:demoflu/src/page/section_collection.dart';
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
    _macroFactory.getMacro<PageMacro>(id, 'Page')(context, this);
  }

  /// Runs a group section macro.
  PageSectionGroup runGroupMacro(dynamic id, BuildContext context) {
    return _macroFactory.getMacro<GroupMacro>(id, 'Group')(context, this);
  }

  /// Runs a heading section macro.
  HeadingSection runHeadingMacro(dynamic id, BuildContext context) {
    return _macroFactory.getMacro<HeadingMacro>(id, 'Heading')(context, this);
  }

  /// Runs a heading section macro.
  TextSection runTextMacro(dynamic id, BuildContext context) {
    return _macroFactory.getMacro<TextMacro>(id, 'Text')(context, this);
  }

  /// Runs a heading section macro.
  BulletsSection runBulletsMacro(dynamic id, BuildContext context) {
    return _macroFactory.getMacro<BulletsMacro>(id, 'Bullets')(context, this);
  }

  /// Runs a divider section macro.
  DividerSection runDividerMacro(dynamic id, BuildContext context) {
    return _macroFactory.getMacro<DividerMacro>(id, 'Divider')(context, this);
  }

  /// Runs a banner section macro.
  BannerSection runBannerMacro(dynamic id, BuildContext context) {
    return _macroFactory.getMacro<BannerMacro>(id, 'Banner')(context, this);
  }

  /// Runs a widget section macro.
  WidgetSection runWidgetMacro(dynamic id, BuildContext context) {
    return _macroFactory.getMacro<WidgetMacro>(id, 'Widget')(context, this);
  }

  /// Runs a code section macro.
  CodeSection runCodeMacro(dynamic id, BuildContext context) {
    return _macroFactory.getMacro<CodeMacro>(id, 'Code')(context, this);
  }

  /// Runs a console section macro.
  ConsoleSection runConsoleMacro(dynamic id, BuildContext context) {
    return _macroFactory.getMacro<ConsoleMacro>(id, 'Console')(context, this);
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
