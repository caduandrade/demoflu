import 'dart:math' as math;
import 'package:demoflu/src/sections/borders/section_border.dart';
import 'package:flutter/material.dart';

class ArrowDownBorder extends SectionBorder{

  @override
  BoxBorder? build() =>_ArrowDownBorder();

}

class _ArrowDownBorder extends BoxBorder {
  _ArrowDownBorder({double left = 10, double arrowHeight = 10, Color? color})
      : left = math.max(0, left),
        arrowHeight = math.max(0, arrowHeight),
        color = color ?? Colors.grey[500]!;

  @override
  final BorderSide bottom = BorderSide.none;

  @override
  final BorderSide top = BorderSide.none;

  final double left;

  final double arrowHeight;

  final Color color;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(left: left);

  @override
  bool get isUniform => false;

  @override
  void paint(Canvas canvas, Rect rect,
      {TextDirection? textDirection,
      BoxShape shape = BoxShape.rectangle,
      BorderRadius? borderRadius}) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double xCenter = rect.left + (left / 2);

    Path path = Path();
    path.moveTo(rect.left, rect.bottom - arrowHeight);
    path.lineTo(rect.left + left, rect.bottom - arrowHeight);
    path.lineTo(xCenter, rect.bottom);
    path.close();

    canvas.drawPath(path, paint);

    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawLine(
        Offset(xCenter, rect.top), Offset(xCenter, rect.bottom), paint);
  }

  @override
  ShapeBorder scale(double t) {
    return _ArrowDownBorder(
        left: math.max(0.0, left * t),
        arrowHeight: math.max(0.0, arrowHeight * t),
        color: color);
  }
}
