import 'package:demoflu/src/demoflu_app.dart';
import 'package:flutter/cupertino.dart';

class ConsoleNotifier extends ValueNotifier<String> {
  ConsoleNotifier() : super('');

  update(String text) {
    String time = DateTime.now().toIso8601String();
    value = '[$time]  $text';
  }
}

class ConsoleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;
    return ValueListenableBuilder<String>(
        valueListenable: state.consoleNotifier,
        builder: (BuildContext context, String value, Widget? child) {
          return SingleChildScrollView(
              child: Text(value), padding: EdgeInsets.all(16));
        });
  }
}
