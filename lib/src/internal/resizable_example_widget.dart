import 'dart:math' as math;

import 'package:demoflu/src/example.dart';
import 'package:demoflu/src/internal/demoflu_settings.dart';
import 'package:demoflu/src/internal/slider.dart';
import 'package:flutter/material.dart';

/// Resizable example widget
class ResizableExampleWidget extends StatefulWidget {
  const ResizableExampleWidget({required this.settings, required this.example});

  final DemoFluSettings settings;
  final AbstractExample example;

  @override
  State<StatefulWidget> createState() => ResizableExampleWidgetState();
}

class ResizableExampleWidgetState extends State<ResizableExampleWidget> {
  @override
  Widget build(BuildContext context) {
    List<LayoutId> children = [];

    children.add(LayoutId(id: _Id.exampleWidget, child: _buildExampleWidget()));

    children.add(LayoutId(
        id: _Id.widthSlider,
        child: DemofluSlider(
            axis: Axis.horizontal,
            value: widget.settings.widthWeight,
            onChanged: (double value) => widget.settings.widthWeight = value)));

    children.add(LayoutId(
        id: _Id.heightSlider,
        child: DemofluSlider(
            axis: Axis.vertical,
            value: widget.settings.heightWeight,
            onChanged: (double value) =>
                widget.settings.heightWeight = value)));

    return Container(
        child: CustomMultiChildLayout(delegate: _Layout(), children: children),
        color: Colors.blueGrey[100]);
  }

  Widget _buildExampleWidget() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double maxWidth = constraints.maxWidth;
      double maxHeight = constraints.maxHeight;
      Size? maxSize = widget.example.maxSize ?? widget.settings.maxSize;
      if (maxSize != null) {
        maxWidth = math.min(maxWidth, maxSize.width);
        maxHeight = math.min(maxHeight, maxSize.height);
      }

      maxWidth = maxWidth * widget.settings.widthWeight;
      maxHeight = maxHeight * widget.settings.heightWeight;

      ConstrainedBox constrainedBox = ConstrainedBox(
          child: widget.example.buildWidget(context),
          constraints:
              BoxConstraints.tightFor(width: maxWidth, height: maxHeight));

      return Container(
          color: widget.settings.exampleBackground,
          child: Center(child: Container(child: constrainedBox)));
    });
  }
}

enum _Id {
  heightSlider,
  widthSlider,
  exampleWidget,
}

class _Layout extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    double reservedWidth = 0;
    if (hasChild(_Id.heightSlider)) {
      reservedWidth = DemofluSlider.crossSize;
    }
    double reservedHeight = 0;
    if (hasChild(_Id.widthSlider)) {
      reservedHeight = DemofluSlider.crossSize;
    }

    if (hasChild(_Id.widthSlider)) {
      double width = math.max(size.width - reservedWidth, 0);
      layoutChild(
          _Id.widthSlider,
          BoxConstraints(
              minWidth: width,
              maxWidth: width,
              minHeight: DemofluSlider.crossSize,
              maxHeight: DemofluSlider.crossSize));
      positionChild(_Id.widthSlider, Offset(reservedWidth, 0));
    }

    if (hasChild(_Id.heightSlider)) {
      double height = size.height - reservedHeight;
      layoutChild(
          _Id.heightSlider,
          BoxConstraints(
              minWidth: DemofluSlider.crossSize,
              maxWidth: DemofluSlider.crossSize,
              minHeight: height,
              maxHeight: height));
      positionChild(_Id.heightSlider, Offset(0, reservedHeight));
    }

    if (hasChild(_Id.exampleWidget)) {
      double width = math.max(0, size.width - reservedWidth);
      double height = math.max(0, size.height - reservedHeight);
      layoutChild(
          _Id.exampleWidget,
          BoxConstraints(
              minWidth: width,
              maxWidth: width,
              minHeight: height,
              maxHeight: height));
      positionChild(_Id.exampleWidget, Offset(reservedWidth, reservedHeight));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
