import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Widget for title session.
@internal
class TitledWidget extends StatelessWidget {
  const TitledWidget(
      {super.key,
      this.title,
      required this.child,
      required this.bordered,
      required this.background,
      required this.padding});

  final String? title;
  final bool bordered;
  final Widget child;
  final Color? background;
  final EdgeInsetsGeometry? padding;

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
          padding: padding,
          decoration: BoxDecoration(
              color: background,
              border: Border.all(color: Colors.grey[200]!, width: 1)),
          child: child);
    }
    return child;
  }
}
