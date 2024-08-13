import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/generated/l10n.dart';
import 'package:moodiary/utils.dart';

class DiaryTextWidget extends StatelessWidget {
  const DiaryTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            isDarkMode(context) ? Colors.grey.shade500 : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(
          Sizes.size5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
        child: TextField(
          minLines: 1,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: S.of(context).enterContentPrompt,
            hintStyle: TextStyle(
              color: Colors.grey.shade800,
              fontSize: Sizes.size14,
            ),
          ),
          cursorColor: Colors.green.shade300,
        ),
      ),
    );
  }
}
