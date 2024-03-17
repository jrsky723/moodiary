import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';

class DialogButton extends StatelessWidget {
  final Color btnColor;
  final String text;
  final Color textColor;
  final void Function() onPressed;

  const DialogButton({
    super.key,
    required this.btnColor,
    required this.text,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Sizes.size8),
      height: Sizes.size40,
      decoration: BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.circular(Sizes.size8),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size14,
          ),
        ),
      ),
    );
  }
}
