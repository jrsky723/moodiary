import 'package:flutter/material.dart';
import 'package:moodiary/constants/mood.dart';
import 'package:moodiary/features/dashboard/models/mood_entry.dart';
import 'package:moodiary/features/dashboard/painters/distribution_chart_painter.dart';

class DistributionChartCard extends StatelessWidget {
  final List<MoodEntry> moodEntries;
  final Text titleText;

  const DistributionChartCard({
    super.key,
    required this.moodEntries,
    this.titleText = const Text(''),
  });

  Map<Mood, double> processMoodEntries(List<MoodEntry> moodEntries) {
    // moodEntries를 받아서, closestMood를 기준으로 분포를 계산
    final Map<Mood, double> data = {};
    int total = 0;

    for (final moodEntry in moodEntries) {
      final mood = moodEntry.closestMood;
      data[mood] = (data[mood] ?? 0) + 1;
      total += 1;
    }

    for (final mood in Mood.values) {
      data[mood] = (data[mood] ?? 0) / total;
    }

    // data의 순서를 value 기준으로 정렬
    final sortedKeys = data.keys.toList()
      ..sort((k1, k2) => data[k2]!.compareTo(data[k1]!));
    final sortedData = {for (var k in sortedKeys) k: data[k]!};

    return sortedData;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: titleText,
        ),
        Flexible(
          flex: 12,
          child: CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: DistributionChartPainter(
              data: processMoodEntries(moodEntries),
            ),
          ),
        ),
      ],
    );
  }
}
