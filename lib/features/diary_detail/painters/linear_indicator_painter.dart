import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';

class LinearIndicatorPainter extends CustomPainter {
  final double value;
  final Color? color;
  final TextSpan label;

  LinearIndicatorPainter({
    required this.value,
    required this.color,
    required this.label,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the axis line
    final axisPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 4.0;
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      axisPaint,
    );

    // Draw the center line
    const lineLenght = 8.0;

    final axisCenterPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1.5;
    canvas.drawLine(
      Offset(size.width / 2, size.height / 2 - lineLenght / 2),
      Offset(size.width / 2, size.height / 2 + lineLenght / 2),
      axisCenterPaint,
    );

    // Map the value from [-1, 1] to [0, size.width]
    final indicatorPosition = (value + 1) / 2 * size.width;
    final indicatorPainter = Paint()
      ..color = color ?? Colors.transparent
      ..style = PaintingStyle.fill;
    // Draw the value indicator circle
    canvas.drawCircle(
      Offset(indicatorPosition, size.height / 2),
      5,
      indicatorPainter,
    );

    // Draw the label
    final labelPainter = TextPainter(
      text: label,
      textDirection: TextDirection.ltr,
    )..layout();
    labelPainter.paint(
      canvas,
      Offset(0, size.height / 2 - Sizes.size24),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
