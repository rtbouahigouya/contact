import 'package:contact/CONSTANT/couleur.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BackgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rectPaint = Paint()..color = maron;
    final ovalPaint = Paint()
      ..color = maron1
      ..style = PaintingStyle.fill; //maron1;

    canvas.drawRect(Rect.largest, rectPaint);

    double L = size.width;
    double l = size.height;
    var a = Offset(-L, -l * .03);
    var b = Offset(L * .5, 1.03 * l);
    canvas.drawArc(
        Rect.fromPoints(a, b), math.pi / 2, -math.pi, true, ovalPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
