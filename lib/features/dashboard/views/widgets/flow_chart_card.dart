import 'package:flutter/material.dart';
import 'package:moodiary/constants/colors.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/dashboard/models/mood_entry.dart';
import 'package:moodiary/features/dashboard/views/painters/gradient_legend_painter.dart';
import 'package:moodiary/features/dashboard/views/painters/line_chart_painter.dart';

class FlowChartCard extends StatelessWidget {
  final List<MoodEntry> moodEntries;
  final bool isXAxis;
  final Text titleText;
  final DateTime startDate;
  final DateTime endDate;

  const FlowChartCard({
    super.key,
    required this.moodEntries,
    this.isXAxis = true,
    this.titleText = const Text(''),
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      isXAxis ? CMColors.unpleasant : CMColors.deactivation,
      CMColors.neutral,
      isXAxis ? CMColors.pleasant : CMColors.activation,
    ];

    // startDate와 endDate 사이로 dates를 생성
    final diff = endDate.difference(startDate).inDays + 1;
    final totalDates = List.generate(diff, (index) {
      return startDate.add(Duration(days: index));
    });

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
                      points: moodEntries
                          .map((e) => isXAxis ? e.offset.dx : e.offset.dy)
                          .toList(),
                      dates: moodEntries.map((e) => e.date).toList(),
                      totalDates: totalDates,
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
