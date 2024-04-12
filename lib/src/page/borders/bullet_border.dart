import 'dart:math' as math;
import 'package:demoflu/src/page/borders/section_border.dart';
import 'package:flutter/material.dart';

class BulletBorder extends SectionBorder {
  @override
  BoxBorder? build() => _BulletBorder();
}

class _BulletBorder extends BoxBorder {
  _BulletBorder({double top = 0, double radius = 10, Color? color})
      : top = BorderSide(width: math.max(0, top)),
        radius = math.max(0, radius),
        color = color ?? Colors.grey[400]!;

  @override
  final BorderSide bottom = BorderSide.none;

  @override
  final BorderSide top;

  final double radius;

  final Color color;

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(left: radius, top: top.width);

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

    final double top = rect.top + (radius / 2);
    final double left = rect.left + (radius / 2);

    Offset circleCenter = Offset(left, top);
    canvas.drawCircle(circleCenter, radius / 2, paint);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawLine(circleCenter, Offset(left, rect.bottom), paint);
  }

  @override
  ShapeBorder scale(double t) {
    return _BulletBorder(
        top: math.max(0.0, top.width * t),
        radius: math.max(0.0, radius * t),
        color: color);
  }
}
