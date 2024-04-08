import 'package:demoflu/src/page.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Widget for title session.
@internal
class TitledWidget extends StatelessWidget {
  const TitledWidget({super.key, required this.section, required this.child});

  final TitledPageSection section;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (section.title != null) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(section.title!), buildContent(context)]);
    }
    return buildContent(context);
  }

  Widget buildContent(BuildContext context) {
    Widget content = section.aspectRatio != null
        ? AspectRatio(aspectRatio: section.aspectRatio!, child: child)
        : child;
    return ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: section.minWidth,
            minHeight: section.minHeight,
            maxWidth: section.maxWidth,
            maxHeight: section.maxHeight),
        child: Container(
            padding: section.padding,
            decoration: BoxDecoration(
                color: section.background,
                border: section.bordered
                    ? Border.all(color: Colors.grey[200]!, width: 1)
                    : null),
            child: content));
  }
}
