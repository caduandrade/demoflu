import 'package:demoflu/src/menu/example_menu_notifier.dart';
import 'package:demoflu/src/menu/example_menu_widgets.dart';
import 'package:flutter/widgets.dart';

abstract class ExampleStateful extends StatefulWidget {
  const ExampleStateful({Key? key, required this.menuNotifier})
      : super(key: key);

  final ExampleMenuNotifier menuNotifier;

  List<ExampleMenuWidget> menuWidgets();
}

abstract class ExampleStatefulState<T extends ExampleStateful>
    extends State<T> {
  @override
  void initState() {
    super.initState();
    widget.menuNotifier.registerButtonClick(onButtonClick);
  }

  void onButtonClick(int buttonId);
}
