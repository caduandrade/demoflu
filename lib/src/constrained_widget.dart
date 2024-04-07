import 'package:demoflu/src/constrained_base_widget.dart';
import 'package:flutter/material.dart';

@deprecated
class ConstrainedWidget extends ConstrainedBaseWidget {
  ConstrainedWidget.withMaxHeight(
      {Key? key, required this.child, required super.maxHeight})
      : super.withMaxHeight(key: key);

  ConstrainedWidget.withAspectRatio(
      {Key? key,
      required this.child,
      required super.size,
      required super.aspectRatio})
      : super.withAspectRatio(key: key);

  final Widget child;

  @override
  Widget buildContent(BuildContext context) {
    return child;
  }
}
