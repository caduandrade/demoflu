import 'package:demoflu/src/page/banner_section.dart';
import 'package:demoflu/src/page/bullets_section.dart';
import 'package:demoflu/src/page/code_section.dart';
import 'package:demoflu/src/page/console_section.dart';
import 'package:demoflu/src/page/divider_section.dart';
import 'package:demoflu/src/page/heading_section.dart';
import 'package:demoflu/src/page/page.dart';
import 'package:demoflu/src/page/page_section_group.dart';
import 'package:demoflu/src/page/text_section.dart';
import 'package:demoflu/src/page/widget_section.dart';
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

  /// Adds a bullets macro.
  void bullets(dynamic id, BulletsMacro macro) {
    _macros[id] = macro;
  }

  /// Adds a divider macro.
  void divider(dynamic id, DividerMacro macro) {
    _macros[id] = macro;
  }

  /// Adds a code macro.
  void code(dynamic id, CodeMacro macro) {
    _macros[id] = macro;
  }

  /// Adds a console macro.
  void console(dynamic id, ConsoleMacro macro) {
    _macros[id] = macro;
  }

  /// Adds a widget macro.
  void widget(dynamic id, WidgetMacro macro) {
    _macros[id] = macro;
  }

  /// Adds a banner macro.
  void banner(dynamic id, BannerMacro macro) {
    _macros[id] = macro;
  }
}

/// Macro for page.
typedef PageMacro = void Function(BuildContext context, DemoFluPage page);

/// Macro for group section.
typedef GroupMacro = PageSectionGroup Function(
    BuildContext context, DemoFluPage page);

/// Macro for heading section.
typedef HeadingMacro = HeadingSection Function(
    BuildContext context, DemoFluPage page);

/// Macro for text section.
typedef TextMacro = TextSection Function(
    BuildContext context, DemoFluPage page);

/// Macro for bullets section.
typedef BulletsMacro = BulletsSection Function(
    BuildContext context, DemoFluPage page);

/// Macro for divider section.
typedef DividerMacro = DividerSection Function(
    BuildContext context, DemoFluPage page);

/// Macro for code section.
typedef CodeMacro = CodeSection Function(
    BuildContext context, DemoFluPage page);

/// Macro for divider section.
typedef ConsoleMacro = ConsoleSection Function(
    BuildContext context, DemoFluPage page);

/// Macro for widget section.
typedef WidgetMacro = WidgetSection Function(
    BuildContext context, DemoFluPage page);

/// Macro for banner section.
typedef BannerMacro = BannerSection Function(
    BuildContext context, DemoFluPage page);

@internal
class MacroFactoryHelper {
  MacroFactoryHelper(this.factory);

  final MacroFactory? factory;

  T getMacro<T>(dynamic id, String type) {
    dynamic macro = factory?._macros[id];
    if (!(macro is T)) {
      throw ArgumentError.value(id, 'id', '${type} macro not found for id.');
    }
    return macro;
  }
}
