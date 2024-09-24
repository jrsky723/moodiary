import 'package:flutter/material.dart';

class GradientLegendPainter extends CustomPainter {
  final List<Color> colors;
  final TextStyle textStyle;

  GradientLegendPainter({
    required this.colors,
    this.textStyle = const TextStyle(
      color: Colors.grey,
      fontSize: 12.0,
    ),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      colors: colors,
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ).createShader(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
    );

    final paint = Paint()
      ..shader = gradient
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      paint,
    );

    // -1.0, -0.5, 0.0, 0.5, 1.0 지점 별 숫자 표시
    for (int i = 0; i < 5; i++) {
      final text = (i - 2).toDouble() / 2; // -1.0, -0.5, 0.0, 0.5, 1.0
      final textPainter = TextPainter(
        text: TextSpan(
          text: text.toString(),
          style: textStyle,
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      // 아래에서 위로
      final y = size.height - size.height * i / 4 - textPainter.height / 2;
      textPainter.paint(
        canvas,
        Offset(-textPainter.width - 4, y),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
