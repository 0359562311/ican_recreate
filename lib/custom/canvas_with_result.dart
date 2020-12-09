import 'package:flutter/material.dart';

class CanvasWithResult extends CustomPainter{

  List<bool> result;

  CanvasWithResult(this.result);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint p = Paint()..color = Colors.redAccent
      ..strokeWidth = 1;

    for(int i=0;i<result.length-1;i++){
      canvas.drawLine(Offset(7 + 13.0*i,result[i] == true ? 40 : 80), Offset(7 + 13.0*(i+1),result[i+1] == true ? 40 : 80), p);
    }

    for(int i=0;i<result.length;i++){
      canvas.drawCircle(Offset(7+13.0*i,result[i] == true ? 40 : 80), 2, Paint()..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }

}