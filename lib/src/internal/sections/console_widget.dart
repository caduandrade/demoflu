import 'package:demoflu/src/internal/print_notifier.dart';
import 'package:demoflu/src/internal/provider.dart';
import 'package:demoflu/src/internal/sections/titled_widget.dart';
import 'package:demoflu/src/page.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Widget for console session.
@internal
class ConsoleWidget extends StatelessWidget {
  ConsoleWidget({required this.section});

  final TitledPageSection section;

  @override
  Widget build(BuildContext context) {
    PrintNotifier printNotifier = DemoFluProvider.printNotifierOf(context);
    return TitledWidget(
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
