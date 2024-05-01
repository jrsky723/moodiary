import 'package:flutter/material.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/utils.dart';

class MoodChartCard extends StatelessWidget {
  final String title;
  final Widget content;

  const MoodChartCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    const contentHeight = 150.0;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size18,
        vertical: Sizes.size20,
      ),
      decoration: BoxDecoration(
        color: isDarkMode(context) ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(Sizes.size16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Gaps.v12,
          SizedBox(
            height: contentHeight,
            child: content,
          ),
        ],
      ),
    );
  }
}
