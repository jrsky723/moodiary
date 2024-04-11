import 'package:flutter/material.dart';
import 'package:moodiary/constants/mood.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/dashboard/models/mood_entry.dart';
import 'package:moodiary/features/dashboard/painters/bar_chart_painter.dart';
import 'package:moodiary/features/dashboard/painters/legend_painter.dart';

class MoodDistChart extends StatelessWidget {
  final List<MoodEntry> moodEntries;
  const MoodDistChart({
    super.key,
    required this.moodEntries,
  });

  Mood getMostFrequentMood() {
    final Map<Mood, int> frequencyMap = {};

    for (var entry in moodEntries) {
      frequencyMap[entry.mood] = (frequencyMap[entry.mood] ?? 0) + 1;
    }

    Mood mostFrequentMood = Mood.values.first;
    int maxFrequency = 0;
    for (var mood in Mood.values) {
      final frequency = frequencyMap[mood] ?? 0;
      if (frequency > maxFrequency) {
        mostFrequentMood = mood;
        maxFrequency = frequency;
      }
    }

    return mostFrequentMood;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;
        final legendWidth = width / 8;
        final barChartWidth = (width - legendWidth);
        final chartHeight = height * 0.9;
        final textHeight = height * 0.1;

        return Column(
          children: [
            Row(
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
                  painter: BarChartPainter(
                    moodEntries: moodEntries,
                  ),
                  child: SizedBox(
                    width: barChartWidth,
                    height: chartHeight,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: textHeight,
              child: Text(
                '가장 많이 기록한 감정: ${getMostFrequentMood().label}',
                style: const TextStyle(
                  fontSize: Sizes.size12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
