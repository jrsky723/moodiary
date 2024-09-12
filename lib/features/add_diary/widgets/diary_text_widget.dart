import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/generated/l10n.dart';
import 'package:moodiary/utils/theme_utils.dart';

class DiaryTextWidget extends ConsumerStatefulWidget {
  final TextEditingController controller;
  const DiaryTextWidget({
    super.key,
    required this.controller,
  });

  @override
  ConsumerState<DiaryTextWidget> createState() => _DiaryTextWidgetState();
}

class _DiaryTextWidgetState extends ConsumerState<DiaryTextWidget> {
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
          controller: widget.controller,
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
