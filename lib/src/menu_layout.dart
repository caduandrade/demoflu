import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MenuLayout extends MultiChildRenderObjectWidget {
  MenuLayout({required List<LayoutConf> children}) : super(children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MenuLayoutRenderBox();
  }
}

class _MenuLayoutElement extends MultiChildRenderObjectElement {
  _MenuLayoutElement(MenuLayout widget) : super(widget);
}

class Conf {
  Conf({required this.row, this.span = false, required this.widget});

  final int row;
  final bool span;
  final bool widget;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Conf &&
          runtimeType == other.runtimeType &&
          row == other.row &&
          span == other.span &&
          widget == other.widget;

  @override
  int get hashCode => row.hashCode ^ span.hashCode ^ widget.hashCode;
}

class LayoutConf extends ParentDataWidget<MenuLayoutParentData> {
  LayoutConf({
    required this.conf,
    required Widget child,
  }) : super(child: child);

  final Conf conf;

  @override
  void applyParentData(RenderObject renderObject) {
    final MenuLayoutParentData parentData =
        renderObject.parentData! as MenuLayoutParentData;
    if (parentData.conf != conf) {
      parentData.conf = conf;
      final AbstractNode? targetParent = renderObject.parent;
      if (targetParent is RenderObject) targetParent.markNeedsLayout();
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => MenuLayout;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Object>('conf.widget', conf.widget));
    properties.add(DiagnosticsProperty<Object>('conf.span', conf.span));
  }
}

class MenuLayoutParentData extends ContainerBoxParentData<RenderBox> {
  Conf? conf;
}

class _MenuLayoutRenderBox extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, MenuLayoutParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, MenuLayoutParentData> {
  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! MenuLayoutParentData)
      child.parentData = MenuLayoutParentData();
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints.loosen();
    RenderBox? child = firstChild;

    Map<int, RenderBox> texts = Map<int, RenderBox>();
    Map<int, RenderBox> widgets = Map<int, RenderBox>();

    List<RenderBox> buttons = [];

    while (child != null) {
      final MenuLayoutParentData childParentData =
          child.parentData! as MenuLayoutParentData;
      if (childParentData.conf == null) {
        throw StateError('?');
        //TODO
      }
      Conf conf = childParentData.conf!;
      if (conf.span) {
        buttons.add(child);
      } else {
        if (conf.widget) {
          widgets[conf.row] = child;
        } else {
          texts[conf.row] = child;
        }
      }
      child = childParentData.nextSibling;
    }

    double maxWidth = 0;
    double maxTextWidth = 0;
    double maxWidgetWidth = 0;
    double totalHeight = 0;

    for (int i = 1; i <= texts.length; i++) {
      RenderBox widgetRenderBox = widgets[i]!;

      widgetRenderBox.layout(constraints, parentUsesSize: true);
      Size widgetSize = widgetRenderBox.size;
      double rowHeight = widgetSize.height;
      maxWidgetWidth = math.max(maxWidgetWidth, widgetSize.width);

      RenderBox textRenderBox = texts[i]!;
      textRenderBox.layout(constraints, parentUsesSize: true);
      Size textSize = textRenderBox.size;
      rowHeight = math.max(rowHeight, textSize.height);
      maxTextWidth = math.max(maxTextWidth, textSize.width);

      totalHeight += rowHeight;
    }

    maxWidth = math.max(maxWidth, maxTextWidth + maxWidgetWidth);

    buttons.forEach((widgetRenderBox) {
      widgetRenderBox.layout(constraints, parentUsesSize: true);
      Size widgetSize = widgetRenderBox.size;
      double rowHeight = widgetSize.height;
      maxWidgetWidth = math.max(maxWidgetWidth, widgetSize.width);

      maxWidth = math.max(maxWidth, widgetSize.width);

      totalHeight += rowHeight;
    });

    double y = 0;
    for (int i = 1; i <= texts.length; i++) {
      RenderBox textRenderBox = texts[i]!;
      MenuLayoutParentData textParentData =
          textRenderBox.parentData! as MenuLayoutParentData;
      RenderBox widgetRenderBox = widgets[i]!;
      MenuLayoutParentData widgetParentData =
          widgetRenderBox.parentData! as MenuLayoutParentData;

      double maxHeight =
          math.max(textRenderBox.size.height, widgetRenderBox.size.height);

      textParentData.offset = Offset(maxTextWidth - textRenderBox.size.width,
          y + (maxHeight - textRenderBox.size.height) / 2);
      widgetParentData.offset = Offset(
          maxTextWidth, y + (maxHeight - widgetRenderBox.size.height) / 2);

      double mh =
          math.max(widgetRenderBox.size.height, textRenderBox.size.height);
      y += mh;
    }

    buttons.forEach((widgetRenderBox) {
      MenuLayoutParentData widgetParentData =
          widgetRenderBox.parentData! as MenuLayoutParentData;

      widgetParentData.offset =
          Offset((maxWidth - widgetRenderBox.size.width) / 2, y);

      y += widgetRenderBox.size.height;
    });

    size = Size(maxWidth, totalHeight);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}
