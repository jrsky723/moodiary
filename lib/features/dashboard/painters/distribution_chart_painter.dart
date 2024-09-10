import 'package:flutter/material.dart';
import 'package:moodiary/features/dashboard/models/distribution_chart_data.dart';

class DistributionChartPainter extends CustomPainter {
  // 분포 차트 그리는 painter
  // data를 받아서 분포 차트를 그림
  // data: DistributionChartData list

  final List<DistributionChartData> data;
  final TextStyle textStyle;

  DistributionChartPainter({
    required this.data,
    required this.textStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 세로로 line으로, distribution을 표현
    // 빈 차트 painter: gray line,
    // 차트 painter: color line: 각 mood에 해당하는 색으로

    for (int i = 0; i < data.length; i++) {
      // 그리는 위치 계산
      final startY = size.height / data.length;
      final gap = size.height / data.length;

      final mood = data[i];
      final ratio = mood.value;
      final label = mood.label;
      final color = mood.color;

      // 빈 차트 그리기
      final emptyPaint = Paint()
        ..color = Colors.grey.withOpacity(0.5)
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round;

      final emptyStartPoint = Offset(0, startY + gap * i);
      final emptyEndPoint = Offset(size.width, startY + gap * i);

      canvas.drawLine(emptyStartPoint, emptyEndPoint, emptyPaint);

      // line 그리기
      final paint = Paint()
        ..color = color
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round;

      final y = startY + gap * i;

      final startPoint = Offset(0, y);
      final endPoint = Offset(size.width * ratio, y);

      // label 그리기
      paintText(
        canvas: canvas,
        offset: Offset(0, y - size.height / data.length / 1.4),
        text: label,
      );

      // percent 그리기
      paintText(
        canvas: canvas,
        offset: Offset(size.width, y - 10),
        text: '${(ratio * 100).toStringAsFixed(1)}%',
        isRight: true,
      );

      canvas.drawLine(startPoint, endPoint, paint);
    }
  }

  void paintText({
    required Canvas canvas,
    required Offset offset,
    required String text,
    isRight = false,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: textStyle,
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    if (isRight) {
      textPainter.paint(
        canvas,
        Offset(
          offset.dx - textPainter.width,
          offset.dy - textPainter.height / 2,
        ),
      );
    } else {
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is DistributionChartPainter) {
      return oldDelegate.data != data;
    }
    return true;
  }
}
