import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomProgressBar extends CustomPainter{

  double percentage;

  CustomProgressBar(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    Offset offset = Offset(0,0);
    Paint p = Paint()
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke
      ..strokeCap= StrokeCap.butt
      ..shader = ui.Gradient.sweep(
          size.center(offset),
          [
            Color.fromRGBO(255, 94, 92, 1),
            Color.fromRGBO(255, 173, 172, 1),
          ],
          [
            0,
            1
          ],
          TileMode.repeated,
          3*pi/2,
          7*pi/2
      );
    Rect rect = Rect.fromLTRB(size.center(offset).dx-50,
        size.center(offset).dy - 50,
        size.center(offset).dx + 50,
        size.center(offset).dy + 50);
    canvas.drawArc(rect, 3*pi/2 - pi/50*percentage , pi/50*percentage, false, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}