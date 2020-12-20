import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CustomChart extends CustomPainter{
  final double percentage;


  CustomChart(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    /// draw 2 rectangles
    Paint colorRect1 = Paint()
      ..shader = ui.Gradient.linear(Offset(0,size.height), Offset(0,size.height - size.height/100*percentage),
          [
            Color.fromRGBO(35, 55, 134, 1),
            Color.fromRGBO(255, 107, 191, 1)
          ]
      );
    Rect rect1 = Rect.fromLTWH(0, size.height*(1-percentage/100), size.width, size.height*percentage/100);
    canvas.drawRect(rect1, colorRect1);

    Paint colorRect2 = Paint()..color = Color.fromRGBO(105, 119, 175, 0.37);
    Rect rect2 = Rect.fromLTWH(0, 0, size.width, size.height*(1-percentage/100));
    canvas.drawRect(rect2, colorRect2);
    /// draw unit
    Paint pUnit1 = Paint()..color = Colors.white
      ..strokeWidth = 1;
    Paint pUnit2 = Paint()..color = Colors.white
      ..strokeWidth = 0.1;
    for(int i=0;i<=100;i++)
      canvas.drawLine(Offset(0,size.height/100*i), Offset(16,size.height/100*i), (i%5 == 0 && i%2 ==1)?pUnit1:pUnit2);

    /// draw level divider
    List<double> lv = [90,80,70,50];
    lv.forEach((e) {
      canvas.drawLine(Offset(0,size.height-size.height/100*e), Offset(size.width,size.height - size.height/100*e), pUnit1);
    });

    /// paint vertical bar
    Paint verticalBarPaint = Paint()
      ..shader = ui.Gradient.linear(Offset(0,size.height), Offset(0,0),[Color.fromRGBO(86, 91, 212, 1),Color.fromRGBO(138, 159, 228, 1)])
      ..strokeWidth = 3;
    canvas.drawLine(Offset(0,0), Offset(0,size.height), verticalBarPaint);

    for(int i=0;i<=100;i+=10){
      canvas.drawCircle(Offset(0,size.height-size.height/100*i), 3, Paint()..color = Colors.white);
    }

    /// draw user correct rate
    Paint pUserCircle = Paint()..strokeWidth = 1;
    canvas.drawCircle(Offset(0,size.height - size.height/100*percentage), 5, pUserCircle..color = Colors.redAccent);
    canvas.drawCircle(Offset(0,size.height - size.height/100*percentage), 3, pUserCircle..color = Colors.white);
  }

  @override
  bool shouldRepaint(CustomChart oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate.percentage != this.percentage;
  }

}