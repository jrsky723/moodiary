import 'package:flutter/material.dart';
import 'package:moodiary/utils/build_utils.dart';

class AnalysisButton extends StatelessWidget {
  final String text;
  final bool disabled;
  final VoidCallback onPressed;

  const AnalysisButton({
    super.key,
    required this.disabled,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = isDarkMode(context);

    final borderColor =
        darkMode ? Theme.of(context).primaryColor : Colors.transparent;
    final backgroundColor =
        darkMode ? Colors.transparent : Theme.of(context).primaryColor;
    const textColor = Colors.white;

    final disabledColor = darkMode ? Colors.transparent : Colors.grey.shade400;
    final disabledBorderColor =
        darkMode ? Colors.grey.shade500 : Colors.transparent;
    final disabledTextColor = Colors.grey.shade600;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          key: ValueKey<bool>(disabled), // 상태를 추적
          onPressed: disabled ? null : onPressed,

          style: ButtonStyle(
            // 테두리 색상 추가
            side: WidgetStateProperty.resolveWith<BorderSide>(
              (states) => BorderSide(
                color: disabled ? disabledBorderColor : borderColor,
                width: 2.0,
              ),
            ),
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (states) => disabled ? disabledColor : backgroundColor,
            ),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: disabled ? disabledTextColor : textColor,
                ),
          ),
        ),
      ),
    );
  }
}
