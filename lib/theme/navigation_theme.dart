import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/theme/material_state_extension.dart';
import 'package:moodiary/utils/build_utils.dart';

NavigationBarThemeData navigationBarThemeData(BuildContext context) {
  final isDark = isDarkMode(context);
  return NavigationBarThemeData(
    height: Sizes.size64,
    elevation: 0,
    backgroundColor: isDark ? Colors.black : Colors.white,
    indicatorColor: Colors.transparent,
    overlayColor: WidgetStateProperty.resolveWith(
      (states) => Colors.transparent,
    ),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.isSelected()) {
        return IconThemeData(
          size: Sizes.size30,
          color: Theme.of(context).primaryColor,
        );
      }
      return IconThemeData(
        color: isDark ? Colors.grey.shade700 : Colors.grey.shade400,
        size: Sizes.size28,
      );
    }),
  );
}
