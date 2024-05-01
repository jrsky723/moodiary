import 'package:flutter/material.dart';

class LegendPainter extends CustomPainter {
  final List<Color> colors;

  LegendPainter({super.repaint, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final double legendX = size.width / 4;
    final double legendY = size.height / colors.length / 2;
    final double radius = size.height / colors.length / 3.7;

    for (int i = 0; i < colors.length; i++) {
      final double y = legendY + i * size.height / colors.length;
      final double x = legendX;

      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
