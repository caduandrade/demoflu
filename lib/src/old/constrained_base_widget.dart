import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@deprecated
@internal
abstract class ConstrainedBaseWidget extends StatelessWidget {
  const ConstrainedBaseWidget.withMaxHeight(
      {super.key, required double maxHeight})
      : this.maxHeight = maxHeight,
        this.size = null,
        this.aspectRatio = null;

  const ConstrainedBaseWidget.withAspectRatio(
      {super.key, required double size, required double aspectRatio})
      : this.size = size,
        this.aspectRatio = aspectRatio,
        this.maxHeight = null;

  final double? maxHeight;
  final double? size;
  final double? aspectRatio;

  Widget buildContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    Widget borderedChild = Container(
        child: buildContent(context),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black26, width: 1)));
    if (maxHeight != null) {
      return Align(
          alignment: Alignment.centerLeft,
          child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxHeight!),
              child: borderedChild));
    } else if (size != null && aspectRatio != null) {
      return Align(
          alignment: Alignment.centerLeft,
          child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size!, maxHeight: 50),
              child: AspectRatio(
                  aspectRatio: aspectRatio!, child: borderedChild)));
    }
    return borderedChild;
  }
}
