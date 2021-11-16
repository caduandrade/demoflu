import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class DemofluSlider extends LeafRenderObjectWidget {
  DemofluSlider({this.value = 0.5, required this.axis, this.onChanged});

  static const double markerCrossSize = 10;
  static const double markerMainSize = 10;
  static const double barCrossSize = 5;
  static const double markerBarCrossSize = 2;
  static const double gap = 6;

  static double get crossSize {
    return DemofluSlider.markerCrossSize +
        DemofluSlider.barCrossSize +
        DemofluSlider.markerBarCrossSize +
        2 * gap;
  }

  final Axis axis;
  final Color barColor = Colors.blueGrey[200]!;
  final Color activeBarColor = Colors.blueGrey[800]!;
  final Color markerColor = Colors.blueGrey[900]!;

  final double value;
  final ValueChanged<double>? onChanged;

  @override
  RenderDemofluSlider createRenderObject(BuildContext context) {
    return RenderDemofluSlider(
        value: value,
        axis: axis,
        barColor: barColor,
        activeBarColor: activeBarColor,
        markerColor: markerColor,
        onChanged: onChanged);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderDemofluSlider renderObject) {
    renderObject
      ..value = value
      ..barColor = barColor
      ..activeBarColor = activeBarColor
      ..markerColor = markerColor
      ..onChanged = onChanged;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Axis>('axis', axis));
    properties.add(ColorProperty('barColor', barColor));
    properties.add(ColorProperty('activeBarColor', activeBarColor));
    properties.add(ColorProperty('markerColor', markerColor));
    properties.add(DoubleProperty('markerHeight', markerCrossSize));
    properties.add(DoubleProperty('value', value));
  }
}

class RenderDemofluSlider extends RenderBox {
  RenderDemofluSlider(
      {required double value,
      required Color barColor,
      required Color activeBarColor,
      required Color markerColor,
      required Axis axis,
      required this.onChanged})
      : _value = value,
        _axis = axis,
        _barColor = barColor,
        _activeBarColor = activeBarColor,
        _markerColor = markerColor {
    _drag = HorizontalDragGestureRecognizer()
      ..onStart = (DragStartDetails details) {
        _notifyMarkerPositionChange(details.localPosition);
      }
      ..onUpdate = (DragUpdateDetails details) {
        _notifyMarkerPositionChange(details.localPosition);
      };
  }

  ValueChanged<double>? onChanged;

  late HorizontalDragGestureRecognizer _drag;

  void _notifyMarkerPositionChange(Offset localPosition) {
    if(axis==Axis.horizontal) {
      final double clickableArea = size.width / 2;
      if (localPosition.dx <= clickableArea) {
        var dx = localPosition.dx.clamp(0, clickableArea);
        value = 1 - (dx / clickableArea);
        if (onChanged != null) {
          onChanged!(value);
        }
      }
    } else {
      final double clickableArea = size.height / 2;
      if (localPosition.dy <= clickableArea) {
        var dy = localPosition.dy.clamp(0, clickableArea);
        value = 1 - (dy / clickableArea);
        if (onChanged != null) {
          onChanged!(value);
        }
      }
    }
  }

  Axis _axis;
  Axis get axis => _axis;
  set axis(Axis axis) {
    if (_axis != axis) {
      _axis = axis;
      markNeedsLayout();
    }
  }

  double _value;
  double get value => _value;
  set value(double value) {
    if (_value != value) {
      _value = value;
      markNeedsPaint();
      markNeedsSemanticsUpdate();
    }
  }

  Color _barColor;
  Color get barColor => _barColor;
  set barColor(Color value) {
    if (_barColor != value) {
      _barColor = value;
      markNeedsPaint();
    }
  }

  Color _activeBarColor;
  Color get activeBarColor => _activeBarColor;
  set activeBarColor(Color value) {
    if (_activeBarColor != value) {
      _activeBarColor = value;
      markNeedsPaint();
    }
  }

  Color _markerColor;
  Color get markerColor => _markerColor;
  set markerColor(Color value) {
    if (_markerColor != value) {
      _markerColor = value;
      markNeedsPaint();
    }
  }

  static const _minDesiredMainSize = 100.0;

  @override
  double computeMinIntrinsicWidth(double height) {
    if(axis==Axis.horizontal) {
      return _minDesiredMainSize;
    }
    return DemofluSlider.crossSize;
  }

  @override
  double computeMaxIntrinsicWidth(double height) => computeMinIntrinsicWidth(height);

  @override
  double computeMinIntrinsicHeight(double width) {
    if(axis==Axis.horizontal) {
      return DemofluSlider.crossSize;
    }
    return _minDesiredMainSize;
  }

  @override
  double computeMaxIntrinsicHeight(double width) => computeMinIntrinsicHeight(width);

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent) {
      _drag.addPointer(event);
    }
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = axis==Axis.horizontal? constraints.maxWidth:DemofluSlider.crossSize;
    final desiredHeight = axis==Axis.horizontal?DemofluSlider.crossSize:constraints.maxHeight;
    final desiredSize = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    var barPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = barColor;
    var activeBarPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = activeBarColor;
    var markerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = markerColor;

    if(axis==Axis.horizontal) {
      final double halfWidth = size.width / 2;

      double reservedHeight = DemofluSlider.barCrossSize + DemofluSlider.gap;
      canvas.drawRect(
          Rect.fromLTWH(0, size.height - reservedHeight, size.width,
              DemofluSlider.barCrossSize),
          barPaint);
      double activeArea = size.width * value;
      canvas.drawRect(
          Rect.fromLTWH((size.width - activeArea) / 2,
              size.height - reservedHeight, activeArea,
              DemofluSlider.barCrossSize),
          activeBarPaint);

      reservedHeight += DemofluSlider.markerCrossSize;
      Path path = Path();
      path.moveTo(
          halfWidth - (halfWidth * value), size.height - reservedHeight);
      path.relativeLineTo(DemofluSlider.markerMainSize, 0);
      path.relativeLineTo(
          -DemofluSlider.markerMainSize, DemofluSlider.markerCrossSize);
      path.close();
      canvas.drawPath(path, markerPaint);

      reservedHeight += DemofluSlider.markerBarCrossSize;
      canvas.drawRect(
          Rect.fromLTWH(0, size.height - reservedHeight, size.width / 2,
              DemofluSlider.markerBarCrossSize),
          markerPaint);
    } else {
      final double halfHeight = size.height / 2;

      double reservedWidth = DemofluSlider.barCrossSize + DemofluSlider.gap;
      canvas.drawRect(
          Rect.fromLTWH(size.width - reservedWidth, 0, DemofluSlider.barCrossSize, size.height),
          barPaint);

      double activeArea = size.height * value;
      canvas.drawRect(
          Rect.fromLTWH(size.width - reservedWidth, (size.height - activeArea) / 2,
              DemofluSlider.barCrossSize,activeArea),
          activeBarPaint);


      reservedWidth += DemofluSlider.markerCrossSize;
      Path path = Path();
      path.moveTo(size.width-reservedWidth,  halfHeight - (halfHeight * value));
      path.relativeLineTo(0, DemofluSlider.markerMainSize);
      path.relativeLineTo(DemofluSlider.markerCrossSize, -DemofluSlider.markerMainSize );
      path.close();
      canvas.drawPath(path, markerPaint);

      reservedWidth += DemofluSlider.markerBarCrossSize;
      canvas.drawRect(
          Rect.fromLTWH(size.width-reservedWidth, 0, DemofluSlider.markerBarCrossSize, size.height / 2),
          markerPaint);
    }

    canvas.restore();
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);

    // description
    config.textDirection = TextDirection.ltr;
    config.label = 'Progress bar';
    config.value = '${(value * 100).round()}%';

    // increase action
    config.onIncrease = increaseAction;
    final increased = value + _semanticActionUnit;
    config.increasedValue = '${((increased).clamp(0.0, 1.0) * 100).round()}%';

    // descrease action
    config.onDecrease = decreaseAction;
    final decreased = value - _semanticActionUnit;
    config.decreasedValue = '${((decreased).clamp(0.0, 1.0) * 100).round()}%';
  }

  static const double _semanticActionUnit = 0.05;

  void increaseAction() {
    final newValue = (value + _semanticActionUnit).clamp(0.0, 1.0);
    if (onChanged != null) {
      onChanged!(newValue);
    }
    markNeedsSemanticsUpdate();
  }

  void decreaseAction() {
    final newValue = (value - _semanticActionUnit).clamp(0.0, 1.0);
    if (onChanged != null) {
      onChanged!(newValue);
    }
    markNeedsSemanticsUpdate();
  }
}
