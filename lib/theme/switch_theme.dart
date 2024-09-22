import 'package:flutter/material.dart';
import 'package:moodiary/utils/build_utils.dart';

SwitchThemeData switchThemeData(BuildContext context) {
  final isDark = isDarkMode(context);
  return SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return Colors.grey.shade400;
      },
    ),
    trackOutlineColor: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return null;
        }
        return Colors.grey.shade300;
      },
    ),
    trackColor: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return null;
        }
        return isDark ? Colors.grey.shade800 : Colors.grey.shade50;
      },
    ),
  );
}
