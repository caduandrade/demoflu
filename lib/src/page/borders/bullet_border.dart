import 'dart:math' as math;
import 'package:demoflu/src/page/borders/section_border.dart';
import 'package:flutter/material.dart';

class BulletBorder extends SectionBorder {
  BulletBorder(
      {required this.top,
      required double diameter,
      required double iconWeight,
      required this.icon,
      required this.color,
      required this.shiftIconY,
      required this.shiftIconX,
      required this.thickness}) {
    this.diameter = diameter;
    this.iconWeight = iconWeight;
  }

  double top;

  double _diameter = 0;

  double get diameter => _diameter;

  set diameter(double value) {
    _diameter = math.max(0, value);
  }

  double _iconWeight = 0;

  double get iconWeight => _iconWeight;

  set iconWeight(double value) {
    _iconWeight = math.max(0, math.min(1, value));
  }

  double shiftIconX;

  double shiftIconY;

  IconData? icon;

  Color color;

  double thickness;

  @override
  BoxBorder? build() => _BulletBorderUI(
      top: top,
      icon: icon,
      iconWeight: iconWeight,
      diameter: diameter,
      color: color,
      shiftIconX: shiftIconX,
      shiftIconY: shiftIconY,
      thickness: thickness);
}

class _BulletBorderUI extends BoxBorder {
  _BulletBorderUI(
      {required double top,
      required this.icon,
      required this.color,
      required this.diameter,
      required this.iconWeight,
      required this.shiftIconX,
      required this.shiftIconY,
      required this.thickness})
      : top = BorderSide(width: top);

  @override
  final BorderSide bottom = BorderSide.none;

  @override
  final BorderSide top;

  final IconData? icon;

  final double shiftIconX;

  final double shiftIconY;

  final Color color;

  final double diameter;

  final double iconWeight;

  final double thickness;

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(left: diameter, top: top.width);

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

    final double circleCenterY = rect.top + (diameter / 2);
    final double circleCenterX = rect.left + (diameter / 2);

    Offset circleCenter = Offset(circleCenterX, circleCenterY);
    canvas.drawCircle(circleCenter, diameter / 2, paint);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = thickness;
    canvas.drawLine(circleCenter, Offset(circleCenterX, rect.bottom), paint);

    IconData? icon = this.icon;
    if (icon != null) {
      double iconSize = diameter * iconWeight;
      final TextStyle textStyle = TextStyle(
        inherit: false,
        color: Colors.white,
        fontSize: iconSize,
        fontFamily: icon.fontFamily,
        package: icon.fontPackage,
        fontFamilyFallback: icon.fontFamilyFallback,
        height: 1.0,
        leadingDistribution: TextLeadingDistribution.even,
      );
      TextSpan textSpan = TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: textStyle,
      );
      TextPainter textPainter =
          TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      textPainter.layout(maxWidth: iconSize, minWidth: iconSize);
      textPainter.paint(
          canvas,
          Offset(circleCenterX - (iconSize / 2) + shiftIconX,
              circleCenterY - (textPainter.height / 2) + shiftIconY));
    }
  }

  @override
  ShapeBorder scale(double t) {
    return _BulletBorderUI(
        top: math.max(0.0, top.width * t),
        diameter: math.max(0.0, diameter * t),
        color: color,
        icon: icon,
        iconWeight: iconWeight,
        shiftIconX: shiftIconX * t,
        shiftIconY: shiftIconY * t,
        thickness: thickness * t);
  }
}
