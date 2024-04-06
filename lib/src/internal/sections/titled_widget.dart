import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
class TitledWidget extends StatelessWidget {
  const TitledWidget(
      {super.key, this.title, required this.child, required this.bordered});

  final String? title;
  final bool bordered;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (title != null) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(title!), buildContent(context)]);
    }
    return buildContent(context);
  }

  Widget buildContent(BuildContext context) {
    if (bordered) {
      return Container(
          child: child,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!, width: 1)));
    }
    return child;
  }
}
