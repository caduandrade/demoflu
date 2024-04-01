import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
class TitledWidget extends StatelessWidget {
  const TitledWidget({super.key, this.title, required this.child});

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (title != null) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Text(title!), buildContent(context)]);
    }
    return buildContent(context);
  }

  Widget buildContent(BuildContext context) {
    return Container(
        child: child,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black26, width: 1)));
  }
}
