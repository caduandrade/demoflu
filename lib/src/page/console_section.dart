import 'package:demoflu/src/macro.dart';
import 'package:demoflu/src/page/borders/section_border.dart';
import 'package:demoflu/src/page/styled_section.dart';
import 'package:demoflu/src/print_notifier.dart';
import 'package:demoflu/src/provider.dart';
import 'package:demoflu/src/theme.dart';
import 'package:flutter/material.dart';

/// Section to display a console output.
class ConsoleSection extends StyledSection {
  ConsoleSection(
      {required super.title,
      required double height,
      required super.border,
      required super.background,
      required super.padding,
      required super.marginLeft,
      required super.marginBottom,
      required super.maxWidth}) {
    this.height = height;
  }

  double _height = 0;

  double get height => _height;

  set height(double value) {
    _height = value >= 0 ? value : 0;
  }

  @override
  double get minHeight => height;

  @override
  double get maxHeight => height;

  @override
  Widget buildContent(BuildContext context) {
    return _ConsoleSectionWidget(section: this);
  }

  @override
  void runMacro({required dynamic id, required BuildContext context}) {
    MacroFactory macroFactory = DemoFluProvider.macroFactoryOf(context);
    ConsoleMacro macro =
        MacroFactoryHelper.getMacro<ConsoleMacro>(id, 'Console', macroFactory);
    macro(context, this);
  }

  @override
  SectionBorder? getBorderFromTheme(DemoFluTheme theme) {
    return theme.consoleBorder;
  }
}

/// Widget for console section.
class _ConsoleSectionWidget extends StatelessWidget {
  _ConsoleSectionWidget({required this.section});

  final ConsoleSection section;

  @override
  Widget build(BuildContext context) {
    PrintNotifier printNotifier = DemoFluProvider.printNotifierOf(context);
    return ListenableBuilder(
        listenable: printNotifier,
        builder: (context, child) {
          return _listView(context);
        });
  }

  Widget _listView(BuildContext context) {
    PrintNotifier printNotifier = DemoFluProvider.printNotifierOf(context);
    return ListView.builder(
        prototypeItem: Text('?'),
        itemBuilder: _itemBuilder,
        itemCount: printNotifier.values.length);
  }

  Widget? _itemBuilder(BuildContext context, int index) {
    PrintNotifier printNotifier = DemoFluProvider.printNotifierOf(context);
    return Text(printNotifier.values[index]);
  }
}
