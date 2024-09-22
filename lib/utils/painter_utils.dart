// 점선을 그리기 위한 함수
import 'package:flutter/material.dart';

void drawDottedVerticalLine(
    Canvas canvas, Offset start, Offset end, Paint paint) {
  const double dashWidth = 4.0;
  const double dashSpace = 4.0;
  final double distance = end.dy - start.dy; // 선의 길이
  final int dashCount = (distance / (dashWidth + dashSpace)).floor(); // 점선의 개수

  for (int i = 0; i < dashCount; i++) {
    final double y = start.dy + (dashWidth + dashSpace) * i;
    canvas.drawLine(Offset(start.dx, y), Offset(end.dx, y + dashWidth), paint);
  }
}

Color getComplementaryColor(Color color) {
  return Color.fromARGB(
    color.alpha,
    255 - color.red,
    255 - color.green,
    255 - color.blue,
  );
}
