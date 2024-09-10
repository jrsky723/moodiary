import 'package:flutter/material.dart';
import 'package:moodiary/constants/colors.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/dashboard/models/mood_entry.dart';
import 'package:moodiary/features/dashboard/painters/gradient_legend_painter.dart';
import 'package:moodiary/features/dashboard/painters/line_chart_painter.dart';

class FlowChartCard extends StatelessWidget {
  final List<MoodEntry> moodEntries;
  final bool isXAxis;
  final Text titleText;

  const FlowChartCard({
    super.key,
    required this.moodEntries,
    this.isXAxis = true,
    this.titleText = const Text(''),
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      isXAxis ? CMColors.unpleasant : CMColors.deactivation,
      CMColors.neutral,
      isXAxis ? CMColors.pleasant : CMColors.activation,
    ];

    return Padding(
      padding: const EdgeInsets.only(
        left: Sizes.size24,
        right: Sizes.size24,
        bottom: Sizes.size16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 1,
            child: titleText,
          ),
          Flexible(
            flex: 5,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: CustomPaint(
                    size: const Size(double.infinity, double.infinity),
                    painter: GradientLegendPainter(
                      colors: colors,
                    ),
                  ),
                ),
                Gaps.h16,
                Flexible(
                  flex: 12,
                  child: CustomPaint(
                    size: const Size(double.infinity, double.infinity),
                    painter: LineChartPainter(
                      dataPoints: moodEntries
                          .map((e) => isXAxis ? e.offset.dx : e.offset.dy)
                          .toList(),
                      dates: moodEntries.map((e) => e.date).toList(),
                      colors: colors,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
