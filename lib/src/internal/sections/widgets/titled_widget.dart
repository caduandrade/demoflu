import 'package:flutter/material.dart';

class TitledWidget extends StatelessWidget {
  const TitledWidget({super.key, required this.title, required this.child});

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (title != null) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(title!), child]);
    }
    return child;
  }
}
