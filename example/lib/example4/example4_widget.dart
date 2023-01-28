import 'package:flutter/material.dart';

class MainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
            child: Text('Tap here: $count'),
            onPressed: () => setState(() {
                  count++;
                })));
  }
}
