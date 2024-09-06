import 'package:flutter/material.dart';

const MaterialColor customPrimarySwatch = MaterialColor(
  0xFF1FBF88,
  <int, Color>{
    50: Color(0xFFE4F7F3),
    100: Color(0xFFBDEBDF),
    200: Color(0xFF92DFCA),
    300: Color(0xFF67D3B6),
    400: Color(0xFF46C9A6),
    500: Color(0xFF1FBF88),
    600: Color(0xFF1AB97F),
    700: Color(0xFF14B175),
    800: Color(0xFF0FAA6B),
    900: Color(0xFF059D5A),
  },
);

class CMColors {
  // Circumplex Model Colors
  static Color borderColor = Colors.grey;
  static const Color pleasant = Color.fromARGB(255, 119, 255, 0);
  static const Color unpleasant = Color.fromARGB(255, 217, 0, 255);
  static const Color activation = Color.fromARGB(255, 255, 17, 0);
  static const Color deactivation = Color.fromARGB(255, 0, 140, 255);
  static const Color neutral = Colors.grey;
}
