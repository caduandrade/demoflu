import 'dart:math' as math;

import 'package:demoflu/src/internal/model.dart';
import 'package:demoflu/src/internal/provider.dart';
import 'package:demoflu/src/internal/slider.dart';
import 'package:flutter/material.dart';

/// Resizable example widget
class ResizableExampleWidget extends StatefulWidget {
  const ResizableExampleWidget();

  @override
  State<StatefulWidget> createState() => ResizableExampleWidgetState();
}

class ResizableExampleWidgetState extends State<ResizableExampleWidget> {
  @override
  Widget build(BuildContext context) {
    DemoFluModel model = DemoFluProvider.modelOf(context);

    List<LayoutId> children = [];

    children.add(
        LayoutId(id: _Id.exampleWidget, child: _buildExampleWidget(context)));

    children.add(LayoutId(
        id: _Id.widthSlider,
        child: DemofluSlider(
            axis: Axis.horizontal,
            value: model.widthWeight,
            onChanged: (double value) => model.widthWeight = value)));

    children.add(LayoutId(
        id: _Id.heightSlider,
        child: DemofluSlider(
            axis: Axis.vertical,
            value: model.heightWeight,
            onChanged: (double value) => model.heightWeight = value)));

    return Container(
        child: CustomMultiChildLayout(delegate: _Layout(), children: children),
        color: Colors.blueGrey[100]);
  }

  Widget _buildExampleWidget(BuildContext context) {
    DemoFluModel model = DemoFluProvider.modelOf(context);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double maxWidth = constraints.maxWidth;
      double maxHeight = constraints.maxHeight;
      //TODO here
      //Size? maxSize = widget.example.maxSize ?? model.maxSize;
      Size? maxSize;
      if (maxSize != null) {
        maxWidth = math.min(maxWidth, maxSize.width);
        maxHeight = math.min(maxHeight, maxSize.height);
      }

      maxWidth = maxWidth * model.widthWeight;
      maxHeight = maxHeight * model.heightWeight;

      //TODO here
      ConstrainedBox constrainedBox = ConstrainedBox(
          child: Container(), //widget.example.buildWidget(context),
          constraints:
              BoxConstraints.tightFor(width: maxWidth, height: maxHeight));

      return Container(
          color: model.exampleBackground,
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
