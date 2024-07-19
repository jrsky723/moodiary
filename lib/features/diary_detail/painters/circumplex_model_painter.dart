import 'dart:math';
import 'package:flutter/material.dart';
import 'package:moodiary/constants/colors.dart';
import 'package:moodiary/constants/sizes.dart';

class CMColors {
  // Circumplex Model Colors
  static Color borderColor = Colors.grey;
  static const Color pleasant = Color.fromARGB(255, 119, 255, 0);
  static const Color unpleasant = Color.fromARGB(255, 217, 0, 255);
  static const Color activation = Color.fromARGB(255, 255, 17, 0);
  static const Color deactivation = Color.fromARGB(255, 0, 140, 255);
}

class CircumplexModelPainter extends CustomPainter {
  final double x;
  final double y;

  CircumplexModelPainter({required Offset moodOffset})
      : x = moodOffset.dx,
        y = moodOffset.dy;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - Sizes.size4;

    paintBackground(canvas, center, radius);
    paintBorder(canvas, center, radius);
    final emotionOffset =
        Offset(center.dx + x * radius, center.dy - y * radius);
    paintEmotion(canvas, emotionOffset);
  }

  void paintBackground(Canvas canvas, Offset center, double radius) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw the circumplex model with gradient colors
    for (double dx = -1; dx <= 1; dx += 0.01) {
      for (double dy = -1; dy <= 1; dy += 0.01) {
        if (dx * dx + dy * dy <= 1) {
          final color = getEmotionColor(dx, dy);
          final offset =
              Offset(center.dx + dx * radius, center.dy - dy * radius);
          paint.color = color;
          canvas.drawCircle(offset, 1, paint);
        }
      }
    }
  }

  void paintBorder(Canvas canvas, Offset center, double radius) {
    // Draw the circumplex model border
    final paint = Paint()
      ..color = CMColors.borderColor
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

  void paintEmotion(Canvas canvas, Offset offset) {
    final emotionBorderPaint = Paint()
      ..color = customPrimarySwatch
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    const emotionRadius = 4.0;
    canvas.drawCircle(offset, emotionRadius, emotionBorderPaint);
  }

  Color getEmotionColor(double x, double y) {
    // Calculate horizontal (x-axis) color interpolation
    final xColor =
        Color.lerp(CMColors.unpleasant, CMColors.pleasant, (x + 1) / 2);
    // Calculate vertical (y-axis) color interpolation
    final yColor =
        Color.lerp(CMColors.deactivation, CMColors.activation, (y + 1) / 2);
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
