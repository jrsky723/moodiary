import 'package:flutter/material.dart';
import 'package:moodiary/constants/mood.dart';
import 'package:moodiary/features/dashboard/models/mood_entry.dart';
import 'package:moodiary/features/dashboard/painters/legend_painter.dart';
import 'package:moodiary/features/dashboard/painters/line_chart_painter.dart';

class MoodFlowChart extends StatelessWidget {
  final List<MoodEntry> moodEntries;
  final bool isMonthly;

  const MoodFlowChart({
    super.key,
    required this.moodEntries,
    required this.isMonthly,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;
        final legendWidth = width / 8;
        final lineChartWidth = width - legendWidth;
        final lineChartHeight = height * 0.8;

        return Row(
          children: [
            CustomPaint(
              painter: LegendPainter(
                colors: Mood.values.map((mood) => mood.color).toList(),
              ),
              child: SizedBox(
                width: legendWidth,
                height: height,
              ),
            ),
            CustomPaint(
              painter: LineChartPainter(
                moodEntries: moodEntries,
                isMonthly: isMonthly,
              ),
              child: SizedBox(
                width: lineChartWidth,
                height: lineChartHeight,
              ),
            ),
          ],
        );
      },
    );
  }
}
