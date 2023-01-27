import 'package:flutter/material.dart';

class MainWidget extends StatelessWidget {
  const MainWidget(this.count);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Example 3: $count'));
  }
}
