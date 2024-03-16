import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/theme/material_state_extension.dart';

IconThemeData navigationIconStyle(
  Set<MaterialState> states,
  BuildContext context,
) {
  if (states.isSelected()) {
    return IconThemeData(
      size: Sizes.size30,
      color: Theme.of(context).primaryColor,
    );
  }
  return IconThemeData(
    color: Colors.grey.shade400,
    size: Sizes.size28,
  );
}
