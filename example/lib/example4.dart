import 'package:demoflu/demoflu.dart';
import 'package:demoflu/src/menu/example_menu_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Example4 extends ExampleStateful {
  Example4(ExampleMenuNotifier menuNotifier)
      : super(menuNotifier: menuNotifier);

  @override
  State<StatefulWidget> createState() => Example4State();

  @override
  List<ExampleMenuWidget> menuWidgets() {
    return [
      MenuButton(id: 1, name: 'Button 1'),
      MenuButton(id: 2, name: 'Button 2')
    ];
  }
}

class Example4State extends ExampleStatefulState<Example4> {
  int? _buttonId;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Example 4: $_buttonId'));
  }

  @override
  void onButtonClick(int buttonId) {
    print('buttonId: $buttonId');
    setState(() {
      _buttonId = buttonId;
    });
  }
}
