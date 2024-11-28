import 'package:flutter/material.dart';
import 'package:moodiary/generated/l10n.dart';
import 'package:moodiary/utils/build_utils.dart';

class AnalysisButton extends StatelessWidget {
  final bool analyzed;
  final VoidCallback onPressed;

  const AnalysisButton({
    super.key,
    required this.analyzed,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = isDarkMode(context);

    final borderColor =
        darkMode ? Theme.of(context).primaryColor : Colors.transparent;
    final backgroundColor =
        darkMode ? Colors.transparent : Theme.of(context).primaryColor;
    const textColor = Colors.white;

    final analyzedColor = darkMode ? Colors.transparent : Colors.grey.shade400;
    final analyzedBorderColor =
        darkMode ? Colors.grey.shade500 : Colors.transparent;
    final analyzedTextColor = Colors.grey.shade600;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          key: ValueKey<bool>(analyzed), // 상태를 추적
          onPressed: analyzed ? null : onPressed,

          style: ButtonStyle(
            // 테두리 색상 추가
            side: WidgetStateProperty.resolveWith<BorderSide>(
              (states) => BorderSide(
                color: analyzed ? analyzedBorderColor : borderColor,
                width: 2.0,
              ),
            ),
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (states) => analyzed ? analyzedColor : backgroundColor,
            ),
          ),
          child: Text(
            analyzed
                ? S.of(context).analysisComplete
                : S.of(context).analyzeMood,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: analyzed ? analyzedTextColor : textColor,
                ),
          ),
        ),
      ),
    );
  }
}
