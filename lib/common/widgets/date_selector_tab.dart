import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';

class DateSelectorTab extends StatelessWidget {
  final String text;
  final void Function() onTap;

  const DateSelectorTab({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(Sizes.size8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: Sizes.size16,
              ),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
