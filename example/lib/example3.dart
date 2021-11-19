import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Example3 extends Example with ExtraWidgetsMixin {
  int _count = 0;
  int get count => _count;
  void incCount() {
    _count++;
    notifyListeners();
  }

  @override
  Widget buildMainWidget(BuildContext context) => Example3Widget(this);

  @override
  Widget? buildExtraWidget(BuildContext context, String name) {
    return ExtraWidget(this);
  }

  @override
  List<String> extraWidgetNames() {
    return ['Buttons'];
  }
}

class ExtraWidget extends StatelessWidget {
  const ExtraWidget(this.example);

  final Example3 example;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: ElevatedButton(
                child: Text('Increment'), onPressed: () => example.incCount())),
        padding: EdgeInsets.all(16));
  }
}

class Example3Widget extends StatelessWidget {
  const Example3Widget(this.example);

  final Example3 example;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Example 3: ${example.count}'));
  }
}
