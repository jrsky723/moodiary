import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moodiary/constants/colors.dart';

// -1 ~ 1 사이의 double value를 받아서 leftColor와 rightColor 사이의 색을 반환
Color? getIndicatorColor({
  required double value,
  required Color leftColor,
  required Color rightColor,
  required Color middleColor,
}) {
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

Color getMoodOffsetColor(Offset offset) {
  final x = offset.dx;
  final y = offset.dy;
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
