import 'package:demoflu/src/internal/print_notifier.dart';
import 'package:demoflu/src/internal/provider.dart';
import 'package:demoflu/src/internal/sections/container_section_ui.dart';
import 'package:demoflu/src/sections/container_section.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Widget for console section.
@internal
class ConsoleSectionUI extends StatelessWidget {
  ConsoleSectionUI({required this.section});

  final ContainerSection section;

  @override
  Widget build(BuildContext context) {
    PrintNotifier printNotifier = DemoFluProvider.printNotifierOf(context);
    return ContainerSectionUI(
        section: section,
        child: ListenableBuilder(
            listenable: printNotifier,
            builder: (context, child) {
              PrintNotifier printNotifier =
                  DemoFluProvider.printNotifierOf(context);
              return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: _itemBuilder,
                  itemCount: printNotifier.values.length);
            }));
  }

  Widget? _itemBuilder(BuildContext context, int index) {
    PrintNotifier printNotifier = DemoFluProvider.printNotifierOf(context);
    return Text(printNotifier.values[index]);
  }
}
