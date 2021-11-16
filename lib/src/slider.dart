import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class DemofluSlider extends LeafRenderObjectWidget {
  DemofluSlider({this.value = 0.5, required this.axis, this.onChanged});

  static const double markerHeight = 10;
  static const double markerWidth = 10;
  static const double barHeight = 5;
  static const double markerBarHeight = 2;
  static const double gap = 6;

  static double get height {
    return DemofluSlider.markerHeight +
        DemofluSlider.barHeight +
        DemofluSlider.markerBarHeight +
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
    properties.add(DoubleProperty('markerHeight', markerHeight));
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
    final double clickableArea = size.width / 2;
    if (localPosition.dx <= clickableArea) {
      var dx = localPosition.dx.clamp(0, clickableArea);
      value = 1 - (dx / clickableArea);
      if (onChanged != null) {
        onChanged!(value);
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

  static const _minDesiredWidth = 100.0;

  @override
  double computeMinIntrinsicWidth(double height) => _minDesiredWidth;

  @override
  double computeMaxIntrinsicWidth(double height) => _minDesiredWidth;

  @override
  double computeMinIntrinsicHeight(double width) => DemofluSlider.height;

  @override
  double computeMaxIntrinsicHeight(double width) => DemofluSlider.height;

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
    final desiredWidth = constraints.maxWidth;
    final desiredHeight = DemofluSlider.height;
    final desiredSize = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    final double halfWidth = size.width / 2;

    var barPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = barColor;
    var activeBarPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = activeBarColor;
    var markerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = markerColor;

    double reservedHeight = DemofluSlider.barHeight + DemofluSlider.gap;
    canvas.drawRect(
        Rect.fromLTWH(0, size.height - reservedHeight, size.width,
            DemofluSlider.barHeight),
        barPaint);
    double activeArea = size.width * value;
    canvas.drawRect(
        Rect.fromLTWH((size.width - activeArea) / 2,
            size.height - reservedHeight, activeArea, DemofluSlider.barHeight),
        activeBarPaint);

    reservedHeight += DemofluSlider.markerHeight;
    Path path = Path();
    path.moveTo(halfWidth - (halfWidth * value), size.height - reservedHeight);
    path.relativeLineTo(DemofluSlider.markerWidth, 0);
    path.relativeLineTo(-DemofluSlider.markerWidth, DemofluSlider.markerHeight);
    path.close();
    canvas.drawPath(path, markerPaint);

    reservedHeight += DemofluSlider.markerBarHeight;
    canvas.drawRect(
        Rect.fromLTWH(0, size.height - reservedHeight, size.width / 2,
            DemofluSlider.markerBarHeight),
        markerPaint);

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
