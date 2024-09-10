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
  final int maxDrawCount;

  LinearIndicatorPainter({
    required this.values,
    required this.leftColor,
    required this.rightColor,
    required this.middleColor,
    required this.label,
    this.indicatorRadius = Sizes.size5,
    this.showAverage = false,
    this.maxDrawCount = 30, // 최대로 그릴 감정 개수
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

    // 최대 그릴 감정 개수에 따라서 step을 정함
    final step = values.length ~/ maxDrawCount;
    for (int i = 0; i < values.length; i++) {
      final value = values[i];
      final indicatorPosition = (value + 1) / 2 * size.width;

      double proportion = (i + 1) / values.length;
      final indicatorPainter = Paint()
        ..color = getIndicatorColor(value)!.withOpacity(proportion)
        ..style = PaintingStyle.fill;
      // step이 0: maxDrawCount > values.length보다 큰 경우 모든 값을 그림
      if (step == 0 || i % step == 0) {
        canvas.drawCircle(
          Offset(indicatorPosition, size.height / 2),
          indicatorRadius,
          indicatorPainter,
        );
      }
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
    if (oldDelegate is LinearIndicatorPainter) {
      return oldDelegate.values != values;
    }
    return false;
  }
}
