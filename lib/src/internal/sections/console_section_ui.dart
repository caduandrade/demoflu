import 'package:demoflu/src/internal/print_notifier.dart';
import 'package:demoflu/src/internal/provider.dart';
import 'package:demoflu/src/internal/sections/widgets/titled_widget.dart';
import 'package:demoflu/src/sections/console_section.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Widget for console section.
@internal
class ConsoleSectionUI extends StatelessWidget {
  ConsoleSectionUI({required this.section});

  final ConsoleSection section;

  @override
  Widget build(BuildContext context) {
    PrintNotifier printNotifier = DemoFluProvider.printNotifierOf(context);
    return ListenableBuilder(
        listenable: printNotifier,
        builder: (context, child) {
          return TitledWidget(title: section.title, child: _container(context));
        });
  }

  Widget _container(BuildContext context) {
    return Container(
        padding: section.padding,
        height: section.height,
        decoration: BoxDecoration(
            color: section.background,
            border: section.bordered
                ? Border.all(color: Colors.grey[200]!, width: 1)
                : null),
        child: _listView(context));
  }

  Widget _listView(BuildContext context) {
    PrintNotifier printNotifier = DemoFluProvider.printNotifierOf(context);
    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: _itemBuilder,
        itemCount: printNotifier.values.length);
  }

  Widget? _itemBuilder(BuildContext context, int index) {
    PrintNotifier printNotifier = DemoFluProvider.printNotifierOf(context);
    return Text(printNotifier.values[index]);
  }
}
