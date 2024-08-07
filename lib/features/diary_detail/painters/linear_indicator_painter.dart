import 'package:flutter/material.dart';
import 'package:moodiary/constants/colors.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/painter_utils.dart';

class LinearIndicatorPainter extends CustomPainter {
  final List<double> values;
  final Color? leftColor;
  final Color? rightColor;
  final Color? middleColor;
  final double indicatorRadius;
  final TextSpan label;
  final bool showAverage;

  LinearIndicatorPainter({
    required this.values,
    required this.leftColor,
    required this.rightColor,
    required this.middleColor,
    required this.label,
    this.indicatorRadius = Sizes.size5,
    this.showAverage = false,
  });

  Color? getIndicatorColor(
      // -1 ~ 1 사이의 double value를 받아서 leftColor와 rightColor 사이의 색을 반환
      double value) {
    final color = Color.lerp(
      leftColor,
      rightColor,
      (value + 1) / 2,
    );
    //  얼마나 원점에 가까이에 있는지에 따라 가운데 색을 섞어줌
    return Color.lerp(
      middleColor,
      color,
      (value).abs() * 1.5,
    );
  }

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
    final lineLenght = size.height / 2;
    final axisCenterPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1.5;
    canvas.drawLine(
      Offset(size.width / 2, size.height / 2 - lineLenght / 2),
      Offset(size.width / 2, size.height / 2 + lineLenght / 2),
      axisCenterPaint,
    );

    for (final value in values) {
      // Map the value from [-1, 1] to [0, size.width]
      final indicatorPosition = (value + 1) / 2 * size.width;
      final indicatorPainter = Paint()
        ..color = getIndicatorColor(value)!
        ..style = PaintingStyle.fill;
      // Draw the value indicator circle
      canvas.drawCircle(
        Offset(indicatorPosition, size.height / 2),
        indicatorRadius,
        indicatorPainter,
      );
    }
    // Draw the label
    final labelPainter = TextPainter(
      text: label,
      textDirection: TextDirection.ltr,
    )..layout();
    labelPainter.paint(
      canvas,
      Offset(0, size.height / 2 - Sizes.size24),
    );

    // Draw the average line
    if (showAverage) {
      final average = values.reduce((a, b) => a + b) / values.length;
      final averagePosition = (average + 1) / 2 * size.width;
      final color = getComplementaryColor(customPrimarySwatch);

      final averagePaint = Paint()
        ..color = color.withOpacity(0.5)
        ..style = PaintingStyle.fill;

      // Draw the average circle
      canvas.drawCircle(
        Offset(averagePosition, size.height / 2),
        indicatorRadius * 1.5,
        averagePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
