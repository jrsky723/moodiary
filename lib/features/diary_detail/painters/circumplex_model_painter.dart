import 'dart:math';

import 'package:flutter/material.dart';

class CircumplexModelPainter extends CustomPainter {
  final double x;
  final double y;

  CircumplexModelPainter({
    required this.x,
    required this.y,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // // Draw the circumplex model with gradient colors
    // for (double dx = -1; dx <= 1; dx += 0.01) {
    //   for (double dy = -1; dy <= 1; dy += 0.01) {
    //     if (dx * dx + dy * dy <= 1) {
    //       final color = getEmotionColor(dx, dy);
    //       final offset =
    //           Offset(center.dx + dx * radius, center.dy - dy * radius);
    //       paint.color = color;
    //       canvas.drawCircle(offset, 1, paint);
    //     }
    //   }
    // }

    // Draw the emotion point
    final emotionPoint = Offset(center.dx + x * radius, center.dy - y * radius);
    final emotionPaint = Paint()
      ..color = getEmotionColor(x, y)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(emotionPoint, 5.0, emotionPaint);

    // Draw the circumplex model border
    paint
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(center, radius, paint);

    // Draw the axes
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy + radius),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx + radius, center.dy),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  Color getEmotionColor(double x, double y) {
    const pleasant = Color.fromARGB(255, 119, 255, 0);
    const unpleasant = Color.fromARGB(255, 217, 0, 255);
    const activation = Color.fromARGB(255, 255, 17, 0);
    const deactivation = Color.fromARGB(255, 0, 140, 255);

    // Calculate horizontal (x-axis) color interpolation
    final xColor = Color.lerp(unpleasant, pleasant, (x + 1) / 2);

    // Calculate vertical (y-axis) color interpolation
    final yColor = Color.lerp(deactivation, activation, (y + 1) / 2);

    // Combine the two colors
    final combinedColor = Color.lerp(xColor, yColor, 0.5)!;

    // Calculate distance from center (0,0) and blend with gray
    final distanceFromCenter = sqrt(x * x + y * y);
    return Color.lerp(
      Colors.grey,
      combinedColor,
      distanceFromCenter + 0.3,
    )!;
  }
}
