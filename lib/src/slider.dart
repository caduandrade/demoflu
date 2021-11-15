import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class DemofluSlider extends LeafRenderObjectWidget {
  DemofluSlider(
      {Key? key,
      this.value = 0.5,
      required this.barColor,
      required this.activeBarColor,
      required this.markerColor,
      this.markerLength = 10,
      this.markerWidth = 10,
      this.barLength = 5,
      this.markerBarLength = 2,
      this.onChanged})
      : super(key: key);

  final Color barColor;
  final Color activeBarColor;
  final Color markerColor;
  final double markerLength;
  final double markerWidth;
  final double barLength;
  final double markerBarLength;

  final double value;
  final ValueChanged<double>? onChanged;

  @override
  RenderDemofluSlider createRenderObject(BuildContext context) {
    return RenderDemofluSlider(
        value: value,
        barColor: barColor,
        activeBarColor: activeBarColor,
        barLength: barLength,
        markerBarLength: markerBarLength,
        markerColor: markerColor,
        markerLength: markerLength,
        markerWidth: markerWidth,
        onChanged: onChanged);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderDemofluSlider renderObject) {
    renderObject
      ..value = value
      ..barColor = barColor
      ..activeBarColor = activeBarColor
      ..barLength = barLength
      ..markerBarLength = markerBarLength
      ..markerColor = markerColor
      ..markerLength = markerLength
      ..markerWidth = markerWidth
      ..onChanged = onChanged;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('barColor', barColor));
    properties.add(ColorProperty('markerColor', markerColor));
    properties.add(DoubleProperty('markerLength', markerLength));
    properties.add(DoubleProperty('value', value));
  }
}

class RenderDemofluSlider extends RenderBox {
  RenderDemofluSlider(
      {required double value,
      required Color barColor,
      required Color activeBarColor,
      required double barLength,
      required double markerBarLength,
      required Color markerColor,
      required double markerLength,
      required double markerWidth,
      required this.onChanged})
      : _value = value,
        _barColor = barColor,
        _activeBarColor = activeBarColor,
        _barLength = barLength,
        _markerBarLength = markerBarLength,
        _markerColor = markerColor,
        _markerLength = markerLength,
        _markerWidth = markerWidth {
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

  double _barLength;
  double get barLength => _barLength;
  set barLength(double value) {
    if (_barLength != value) {
      _barLength = value;
      markNeedsLayout();
    }
  }

  double _markerBarLength;
  double get markerBarLength => _markerBarLength;
  set markerBarLength(double value) {
    if (_markerBarLength != value) {
      _markerBarLength = value;
      markNeedsLayout();
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

  double _markerLength;
  double get markerLength => _markerLength;
  set markerLength(double value) {
    if (_markerLength != value) {
      _markerLength = value;
      markNeedsLayout();
    }
  }

  double _markerWidth;
  double get markerWidth => _markerWidth;
  set markerWidth(double value) {
    if (_markerWidth != value) {
      _markerWidth = value;
      markNeedsLayout();
    }
  }

  static const _minDesiredWidth = 100.0;

  double _minHeight() {
    return markerLength + barLength + markerBarLength;
  }

  @override
  double computeMinIntrinsicWidth(double height) => _minDesiredWidth;

  @override
  double computeMaxIntrinsicWidth(double height) => _minDesiredWidth;

  @override
  double computeMinIntrinsicHeight(double width) => _minHeight();

  @override
  double computeMaxIntrinsicHeight(double width) => _minHeight();

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
    final desiredHeight = _minHeight();
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

    double reservedHeight = barLength;
    canvas.drawRect(
        Rect.fromLTWH(0, size.height - reservedHeight, size.width, barLength),
        barPaint);
    double activeArea = size.width * value;
    canvas.drawRect(
        Rect.fromLTWH((size.width - activeArea) / 2,
            size.height - reservedHeight, activeArea, barLength),
        activeBarPaint);

    reservedHeight += markerLength;
    Path path = Path();
    path.moveTo(halfWidth - (halfWidth * value), size.height - reservedHeight);
    path.relativeLineTo(markerWidth, 0);
    path.relativeLineTo(-markerWidth, markerLength);
    path.close();
    canvas.drawPath(path, markerPaint);

    reservedHeight += markerBarLength;
    canvas.drawRect(
        Rect.fromLTWH(
            0, size.height - reservedHeight, size.width / 2, markerBarLength),
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
