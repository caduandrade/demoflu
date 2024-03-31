import 'package:flutter/material.dart';

class AddonExample extends StatelessWidget {
  const AddonExample(this.count, {super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Count: $count'));
  }
}
