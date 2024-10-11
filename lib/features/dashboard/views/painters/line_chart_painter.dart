import 'package:flutter/material.dart';

class LineChartPainter extends CustomPainter {
  // 날짜별, offset의 변화를 통해 선을 그리는 painter
  // 날짜는 전체 기간에서 4개의 날짜를 선택하여 그림 (4등분)
  // 아래 색상과, 위의 색상 두개를 받아서, 사이의 그라데이션을 적용
  // x, y 좌표를 이용할 건지, bool 변수를 통해 선택 가능
  final List<double> points;
  final List<DateTime> dates;
  final List<DateTime> totalDates;
  final List<Color> colors;
  final int dateCount;
  final TextStyle textStyle;
  final int maxDrawCount; // 최대 그릴 감정 개수

  LineChartPainter({
    required this.points, // -1.0 ~ 1.0
    required this.dates,
    required this.totalDates,
    required this.colors,
    this.dateCount = 4,
    this.textStyle = const TextStyle(
      color: Colors.grey,
      fontSize: 12.0,
    ),
    this.maxDrawCount = 30, // 최대로 그릴 감정 개수
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
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: colors,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final path = Path();

    // points 리스트가 비어있을 경우 반환
    if (points.isEmpty || dates.isEmpty || totalDates.isEmpty) return;

    // 전체 날짜 범위 계산 (기간의 시작과 끝)
    final totalDays = totalDates.last.difference(totalDates.first).inDays;

    // 첫 번째 좌표 설정 (첫 번째 날짜의 위치를 기준으로 시작)
    double startX =
        (dates[0].difference(totalDates.first).inDays / totalDays) * size.width;
    double startY = size.height *
        (1 - (points[0] + 1) / 2); // -1.0 ~ 1.0 범위를 0 ~ height로 변환
    path.moveTo(startX, startY);

    // 나머지 좌표들을 계산하고 선을 이어줌
    for (int i = 1; i < points.length; i++) {
      // 각 날짜별로 x 좌표 계산 (날짜 차이를 기반으로 비율 계산)
      double x = (dates[i].difference(totalDates.first).inDays / totalDays) *
          size.width;
      double y =
          size.height * (1 - (points[i] + 1) / 2); // y 좌표는 points 값에 따라 계산
      path.lineTo(x, y);
    }

    // 캔버스에 그리기
    canvas.drawPath(path, gradientPaint);
  }

  void drawDate(Canvas canvas, Size size) {
    // 전체 date에서 dateCount로 등분하여, 각 지점에 날짜를 표시
    // 시작, 끝, 중간...
    final dates = [
      for (int i = 0; i < dateCount; i++)
        totalDates[i * (totalDates.length - 1) ~/ (dateCount - 1)]
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
      if (oldDelegate.points != points ||
          oldDelegate.dates != dates ||
          oldDelegate.totalDates != totalDates ||
          oldDelegate.colors != colors) {
        return true;
      }
    }
    return true;
  }
}
