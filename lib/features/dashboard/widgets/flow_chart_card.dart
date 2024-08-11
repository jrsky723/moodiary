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

  const FlowChartCard({
    super.key,
    required this.moodEntries,
    this.isXAxis = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      isXAxis ? CMColors.unpleasant : CMColors.deactivation,
      CMColors.neutral,
      isXAxis ? CMColors.pleasant : CMColors.activation,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size24,
        vertical: Sizes.size16,
      ),
      child: Row(
        children: [
          Flexible(
              flex: 1,
              child: CustomPaint(
                size: const Size(double.infinity, double.infinity),
                painter: GradientLegendPainter(
                  colors: colors,
                ),
              )),
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
    );
  }
}
