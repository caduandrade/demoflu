import 'package:flutter/material.dart';

class ListenableExample extends StatelessWidget {
  const ListenableExample(this.count, {super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Count: $count'));
  }
}
