import 'package:demoflu/src/internal/print_notifier.dart';
import 'package:demoflu/src/internal/provider.dart';
import 'package:flutter/material.dart';

/// Console widget
class ConsoleWidget extends StatelessWidget {
  ConsoleWidget({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    PrintNotifier printNotifier = DemoFluProvider.printNotifierOf(context);
    return ListenableBuilder(
        listenable: printNotifier,
        builder: (context, child) {
          PrintNotifier printNotifier =
              DemoFluProvider.printNotifierOf(context);
          return Container(
              padding: EdgeInsets.all(8),
              height: height,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: _itemBuilder,
                  itemCount: printNotifier.values.length),
              color: Colors.white);
        });
  }

  Widget? _itemBuilder(BuildContext context, int index) {
    PrintNotifier printNotifier = DemoFluProvider.printNotifierOf(context);
    return Text(printNotifier.values[index]);
  }
}
