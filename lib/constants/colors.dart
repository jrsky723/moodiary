import 'package:flutter/material.dart';

const MaterialColor customPrimarySwatch = MaterialColor(
  0xFF1FBF88,
  <int, Color>{
    50: Color(0xFFE0F2F1),
    100: Color(0xFFB2DFDB),
    200: Color(0xFF80CBC4),
    300: Color(0xFF4DB6AC),
    400: Color(0xFF26A69A),
    500: Color(0xFF1FBF88),
    600: Color(0xFF00897B),
    700: Color(0xFF00796B),
    800: Color(0xFF00695C),
    900: Color(0xFF004D40),
  },
);

class CMColors {
  // Circumplex Model Colors
  static Color borderColor = Colors.grey;
  static const Color pleasant = Color.fromARGB(255, 119, 255, 0);
  static const Color unpleasant = Color.fromARGB(255, 217, 0, 255);
  static const Color activation = Color.fromARGB(255, 255, 17, 0);
  static const Color deactivation = Color.fromARGB(255, 0, 140, 255);
}
