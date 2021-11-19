import 'package:demoflu/src/demoflu_settings.dart';
import 'package:flutter/widgets.dart';

class ConsoleNotifier extends ValueNotifier<String> {
  int _count = 0;

  ConsoleNotifier() : super('');

  update(String text) {
    _count++;
    value = '[$_count]  $text';
  }
}

class ConsoleWidget extends StatelessWidget {
  ConsoleWidget({required this.settings});

  final DemoFluSettings settings;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
        valueListenable: settings.consoleNotifier,
        builder: (BuildContext context, String value, Widget? child) {
          return SingleChildScrollView(
              controller: ScrollController(),
              child: Text(value),
              padding: EdgeInsets.all(16));
        });
  }
}
