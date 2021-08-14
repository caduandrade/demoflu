import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Example4 extends StatefulWidget {
  final ExampleMenuNotifier exampleMenuNotifier;

  const Example4(this.exampleMenuNotifier);

  @override
  State<StatefulWidget> createState() => Example4State();
}

class Example4State extends State<Example4> {
  int? _index;

  @override
  void initState() {
    super.initState();
    widget.exampleMenuNotifier.registerButtonClick(onClick);
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Example 4: $_index'));
  }

  void onClick(int index) {
    print('button: $index');
    setState(() {
      _index = index;
    });
  }
}
