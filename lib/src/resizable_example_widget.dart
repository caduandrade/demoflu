import 'dart:math' as math;

import 'package:demoflu/src/demoflu_app.dart';
import 'package:demoflu/src/menu_item.dart';
import 'package:demoflu/src/slider.dart';
import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';

class ResizableExampleWidget extends StatelessWidget {
  const ResizableExampleWidget({required this.menuItem});

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    DemoFluAppState state = DemoFluAppState.of(context)!;

    List<LayoutId> children = [];
    if (state.widgetVisible) {
      MenuItem menuItem = state.currentMenuItem!;
      children.add(
          LayoutId(id: _Id.exampleWidget, child: _buildExampleWidget(state)));
      if (state.isResizable(menuItem)) {
        children.add(LayoutId(
            id: _Id.widthSlider,
            child: DemofluSlider(
                axis: Axis.horizontal,
                value: state.widthWeight,
                onChanged: (double value) => state.widthWeight = value)));
        /*
        children.add(LayoutId(
            id: _Id.heightSlider,
            child: DemofluSlider(
                axis: Axis.vertical,
                value: state.heightWeight,
                onChanged: (double value) => state.heightWeight = value)));
        */
      }
    }

    return Container(
        child: CustomMultiChildLayout(delegate: _Layout(), children: children),
        color: Colors.blueGrey[100]);
  }

  Widget _buildExampleWidget(DemoFluAppState state) {
    MenuItem menuItem = state.currentMenuItem!;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double maxWidth = constraints.maxWidth;
      double maxHeight = constraints.maxHeight;
      Size? maxSize = state.getMaxSize(menuItem);
      if (maxSize != null) {
        maxWidth = math.min(maxWidth, maxSize.width);
        maxHeight = math.min(maxHeight, maxSize.height);
      }
      if (state.isResizable(menuItem)) {
        maxWidth = maxWidth * state.widthWeight;
        maxHeight = maxHeight * state.heightWeight;
      }
      ConstrainedBox constrainedBox = ConstrainedBox(
          child: MultiSplitViewTheme(
              child: menuItem.example!, data: MultiSplitViewThemeData()),
          constraints:
              BoxConstraints.tightFor(width: maxWidth, height: maxHeight));

      return Container(
          color: state.widgetBackground,
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
      reservedWidth = DemofluSlider.height;
    }
    double reservedHeight = 0;
    if (hasChild(_Id.widthSlider)) {
      reservedHeight = DemofluSlider.height;
    }

    if (hasChild(_Id.widthSlider)) {
      double width = size.width - reservedWidth;
      layoutChild(
          _Id.widthSlider,
          BoxConstraints(
              minWidth: width,
              maxWidth: width,
              minHeight: DemofluSlider.height,
              maxHeight: DemofluSlider.height));
      positionChild(_Id.widthSlider, Offset(reservedWidth, 0));
    }

    if (hasChild(_Id.heightSlider)) {
      double height = size.height - reservedHeight;
      layoutChild(
          _Id.heightSlider,
          BoxConstraints(
              minWidth: DemofluSlider.height,
              maxWidth: DemofluSlider.height,
              minHeight: height,
              maxHeight: height));
      positionChild(_Id.heightSlider, Offset(0, reservedHeight));
    }

    if (hasChild(_Id.exampleWidget)) {
      layoutChild(
          _Id.exampleWidget,
          BoxConstraints(
              minWidth: size.width - reservedWidth,
              maxWidth: size.width - reservedWidth,
              minHeight: size.height - reservedHeight,
              maxHeight: size.height - reservedHeight));
      positionChild(_Id.exampleWidget, Offset(reservedWidth, reservedHeight));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
