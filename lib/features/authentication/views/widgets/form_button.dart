import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';

class FormButton extends StatelessWidget {
  final bool disabled;
  final Function()? onTap;
  final String text;

  const FormButton({
    super.key,
    required this.disabled,
    this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 300,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Sizes.size5,
            ),
            color: disabled
                ? Colors.grey.shade300
                : Theme.of(context).primaryColor,
          ),
          child: AnimatedDefaultTextStyle(
            style: TextStyle(
              color: disabled ? Colors.grey.shade400 : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: Sizes.size16,
            ),
            duration: const Duration(
              milliseconds: 300,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
