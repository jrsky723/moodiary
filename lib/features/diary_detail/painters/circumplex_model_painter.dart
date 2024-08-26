import 'package:flutter/material.dart';
import 'package:moodiary/constants/colors.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/painter_utils.dart';
import 'package:moodiary/utils/color_utils.dart';

class CircumplexModelPainter extends CustomPainter {
  final List<Offset> moodOffsets;
  final bool showAverage;
  final int maxDrawCount;

  CircumplexModelPainter({
    required this.moodOffsets,
    this.showAverage = false,
    this.maxDrawCount = 30, // 최대로 그릴 감정 개수
  });
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final double radius;
    if (size.width < size.height) {
      radius = size.width / 2 - Sizes.size4;
    } else {
      radius = size.height / 2 - Sizes.size4;
    }

    paintBackground(canvas, center, radius);
    paintBorder(canvas, center, radius);
    // 전체 리스트에서, maxDrawCount만 추출 (비율 유지)
    final step = moodOffsets.length ~/ maxDrawCount;
    for (int i = 0; i < moodOffsets.length; i++) {
      final offset = moodOffsets[i];
      final emotionOffset = Offset(
        center.dx + offset.dx * radius,
        center.dy - offset.dy * radius,
      );
      if (step == 0 || i % step == 0) {
        paintEmotion(canvas, emotionOffset, radius, i, moodOffsets.length);
      }
    }
    if (showAverage) {
      paintAveragePoint(canvas, center, radius);
    }
  }

  void paintEmotion(
    Canvas canvas,
    Offset offset,
    double radius,
    int index,
    int length,
  ) {
    // 순서에 따라 opacity는 index에 비례
    double proportion = (index + 1) / length;

    final emotionBorderPaint = Paint()
      ..color = customPrimarySwatch.withOpacity(proportion)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final double emotionRadius = radius / 15;
    canvas.drawCircle(offset, emotionRadius, emotionBorderPaint);
  }

  void paintBackground(Canvas canvas, Offset center, double radius) {
    final paint = Paint()..style = PaintingStyle.fill;
    // Draw the circumplex model with gradient colors
    for (double dx = -1; dx <= 1; dx += 0.01) {
      for (double dy = -1; dy <= 1; dy += 0.01) {
        if (dx * dx + dy * dy <= 1) {
          final color = getMoodOffsetColor(Offset(dx, dy));
          final offset =
              Offset(center.dx + dx * radius, center.dy - dy * radius);
          paint.color = color;
          canvas.drawCircle(offset, 1, paint);
        }
      }
    }
  }

  void paintAveragePoint(Canvas canvas, Offset center, double radius) {
    if (moodOffsets.isEmpty) return;
    final avgOffset =
        moodOffsets.reduce((a, b) => a + b) / moodOffsets.length.toDouble();
    final averagePoint = Offset(
      center.dx + avgOffset.dx * radius,
      center.dy - avgOffset.dy * radius,
    );

    for (int i = 1; i <= 5; i++) {
      final color = Color.lerp(customPrimarySwatch.shade900,
          customPrimarySwatch.shade50, (5 - i) / 4)!;
      final paint = Paint()
        ..color = color.withOpacity(0.5 - 0.1 * i)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(averagePoint, (radius / 12) * i, paint);
    }

    final complementaryColor = getComplementaryColor(customPrimarySwatch);

    final paint = Paint()
      ..color = complementaryColor.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(averagePoint, radius / 15, borderPaint);
    canvas.drawCircle(averagePoint, radius / 15, paint);
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is CircumplexModelPainter) {
      return oldDelegate.moodOffsets != moodOffsets;
    }
    return false;
  }
}
