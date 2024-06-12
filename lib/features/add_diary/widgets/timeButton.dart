import 'package:flutter/material.dart';

class timeButton extends StatelessWidget {
  final String title;
  final String formattedTime;
  final VoidCallback onPressed;
  final bool isDarkMode;

  const timeButton({
    super.key,
    required this.title,
    required this.formattedTime,
    required this.onPressed,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            backgroundColor:
                isDarkMode ? Colors.grey.shade500 : Colors.grey.shade300,
            surfaceTintColor: Colors.black,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          child: Text(
            formattedTime,
            style: TextStyle(color: Colors.grey.shade800),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
