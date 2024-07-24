import 'package:flutter/material.dart';
import 'package:moodiary/utils/theme_utils.dart';

SwitchThemeData switchThemeData(BuildContext context) {
  final isDark = isDarkMode(context);
  return SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        }
        return Colors.grey.shade400;
      },
    ),
    trackOutlineColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return null;
        }
        return Colors.grey.shade300;
      },
    ),
    trackColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return null;
        }
        return isDark ? Colors.grey.shade800 : Colors.grey.shade50;
      },
    ),
  );
}
