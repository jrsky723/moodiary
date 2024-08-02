import 'package:flutter/material.dart';

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
