import 'package:demoflu/src/page/heading_section.dart';
import 'package:demoflu/src/page/page.dart';
import 'package:demoflu/src/page/page_section_group.dart';
import 'package:demoflu/src/page/text_section.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// The macro factory
class MacroFactory {
  final Map<dynamic, dynamic> _macros = {};

  /// Adds a page macro.
  void page(dynamic id, PageMacro macro) {
    _macros[id] = macro;
  }

  /// Adds a group macro.
  void group(dynamic id, GroupMacro macro) {
    _macros[id] = macro;
  }

  /// Adds a heading macro.
  void heading(dynamic id, HeadingMacro macro) {
    _macros[id] = macro;
  }

  /// Adds a text macro.
  void text(dynamic id, TextMacro macro) {
    _macros[id] = macro;
  }
}

/// Macro for a page.
typedef PageMacro = void Function(BuildContext context, DemoFluPage page);

/// Macro for a group section of a page.
typedef GroupMacro = PageSectionGroup Function(
    BuildContext context, DemoFluPage page);

/// Macro for a heading section of a page.
typedef HeadingMacro = HeadingSection Function(
    BuildContext context, DemoFluPage page);

/// Macro for a text section of a page.
typedef TextMacro = TextSection Function(
    BuildContext context, DemoFluPage page);

@internal
class MacroFactoryHelper {
  MacroFactoryHelper(this.factory);

  final MacroFactory? factory;

  PageMacro getPageMacro(dynamic id) {
    PageMacro? macro = factory?._macros[id];
    if (!(macro is PageMacro)) {
      throw ArgumentError.value(id, 'id', 'Page macro not found for id.');
    }
    return macro;
  }

  GroupMacro getGroupMacro(dynamic id) {
    dynamic macro = factory?._macros[id];
    if (!(macro is GroupMacro)) {
      throw ArgumentError.value(id, 'id', 'Group macro not found for id.');
    }
    return macro;
  }

  HeadingMacro getHeadingMacro(dynamic id) {
    dynamic macro = factory?._macros[id];
    if (!(macro is HeadingMacro)) {
      throw ArgumentError.value(id, 'id', 'Heading macro not found for id.');
    }
    return macro;
  }

  TextMacro getTextMacro(dynamic id) {
    dynamic macro = factory?._macros[id];
    if (!(macro is TextMacro)) {
      throw ArgumentError.value(id, 'id', 'Text macro not found for id.');
    }
    return macro;
  }
}
