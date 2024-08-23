import 'package:flutter/material.dart';

class LineChartPainter extends CustomPainter {
  // 날짜별, offset의 변화를 통해 선을 그리는 painter
  // 날짜는 전체 기간에서 4개의 날짜를 선택하여 그림 (4등분)
  // 아래 색상과, 위의 색상 두개를 받아서, 사이의 그라데이션을 적용
  // x, y 좌표를 이용할 건지, bool 변수를 통해 선택 가능
  final List<double> dataPoints;
  final List<DateTime> dates;
  final List<Color> colors;
  final int dateCount;
  final TextStyle textStyle;

  LineChartPainter({
    required this.dataPoints, // -1.0 ~ 1.0
    required this.dates,
    required this.colors,
    this.dateCount = 4,
    this.textStyle = const TextStyle(
      color: Colors.grey,
      fontSize: 12.0,
    ),
  });

  @override
  void paint(Canvas canvas, Size size) {
    drawAxis(canvas, size);
    drawLine(canvas, size);
    drawDate(canvas, size);
  }

  void drawAxis(Canvas canvas, Size size) {
    final axisPaint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..strokeWidth = 0.5;

    // x축 및 값들을 나타내는 선 (-1.0, -0.5, 0.0, 0.5, 1.0)
    for (int i = 0; i < 5; i++) {
      final y = size.height * i / 4;
      final start = Offset(0, y);
      final end = Offset(size.width, y);
      canvas.drawLine(start, end, axisPaint);
    }
  }

  void drawLine(Canvas canvas, Size size) {
    final gradient = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: colors,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 2.5;

    for (int i = 0; i < dataPoints.length - 1; i++) {
      final startX = size.width * i / (dataPoints.length - 1);
      final endX = size.width * (i + 1) / (dataPoints.length - 1);

      final startY = size.height * (1 - dataPoints[i]) / 2;
      final endY = size.height * (1 - dataPoints[i + 1]) / 2;

      final startPoint = Offset(startX, startY);
      final endPoint = Offset(endX, endY);
      canvas.drawLine(startPoint, endPoint, gradient);
    }
  }

  void drawDate(Canvas canvas, Size size) {
    // 전체 date에서 dateCount로 등분하여, 각 지점에 날짜를 표시
    // 시작, 끝, 중간...
    final dates = [
      for (int i = 0; i < dateCount; i++)
        this.dates[i * (this.dates.length - 1) ~/ (dateCount - 1)]
    ];

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < dateCount; i++) {
      final x = size.width * i / (dateCount - 1);
      final dateText = "${dates[i].month}/${dates[i].day}";
      textPainter.text = TextSpan(
        text: dateText,
        style: textStyle,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      textPainter.paint(
        canvas,
        Offset(
          x - textPainter.width / 2,
          size.height + 4.0,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is LineChartPainter) {
      // 비교할 변수들을 체크하여, 재페인팅이 필요한 경우 true 반환
      return oldDelegate.dataPoints != dataPoints ||
          oldDelegate.dates != dates ||
          oldDelegate.colors != colors;
    }
    return true;
  }
}
