import 'package:flutter/material.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/mood.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/dashboard/models/mood_entry.dart';
import 'package:moodiary/features/dashboard/painters/legend_painter.dart';
import 'package:moodiary/features/dashboard/painters/line_chart_painter.dart';

class MoodFlowChart extends StatelessWidget {
  final List<MoodEntry> moodEntries;

  const MoodFlowChart({super.key, required this.moodEntries});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size18,
        vertical: Sizes.size20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizes.size16),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Text(
                "기분 흐름",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Gaps.v12,
          LayoutBuilder(
            builder: (context, constraints) {
              const double chartHeight = 130.0;
              final totalWidth = constraints.maxWidth;
              final legendWidth = totalWidth / 8;
              final lineChartWidth = totalWidth - legendWidth;
              const lineChartHeight = chartHeight * 0.8;

              return Row(
                children: [
                  CustomPaint(
                    painter: LegendPainter(
                      colors: Mood.values.map((mood) => mood.color).toList(),
                    ),
                    child: SizedBox(
                      width: legendWidth,
                      height: chartHeight,
                    ),
                  ),
                  CustomPaint(
                    painter: LineChartPainter(
                      moodEntries: moodEntries,
                    ),
                    child: SizedBox(
                      width: lineChartWidth,
                      height: lineChartHeight,
                    ),
                  ),
                  const CustomPaint(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
