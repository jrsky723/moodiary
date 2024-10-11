import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/utils/build_utils.dart';

class FormActionButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const FormActionButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: isDarkMode(context) ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size40,
        ),
        textStyle: const TextStyle(
          fontSize: Sizes.size18,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
      ),
    );
  }
}
