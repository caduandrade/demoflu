import 'package:demoflu/src/demoflu_app.dart';
import 'package:flutter/cupertino.dart';

class ConsoleNotifier extends ValueNotifier<String> {

  int _count =0;

  ConsoleNotifier() : super('');

  update(String text) {
    _count++;
    value = '[$_count]  $text';
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
              controller: ScrollController(),
              child: Text(value),
              padding: EdgeInsets.all(16));
        });
  }
}
