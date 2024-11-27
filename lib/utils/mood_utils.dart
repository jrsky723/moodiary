import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moodiary/constants/mood.dart';
import 'package:moodiary/features/dashboard/models/mood_entry.dart';

Offset getMoodOffset(Mood mood) {
  if (mood == Mood.none) {
    return Offset.zero;
  }
  const int numPositions = 16;
  const double angleOffset = 2 * pi / numPositions;
  const double startAngle = pi / 8;
  int index = Mood.values.indexOf(mood);
  return Offset(
    cos(startAngle + angleOffset * index),
    sin(startAngle + angleOffset * index),
  );
}

Random random = Random();

Offset randomOffset() {
  double angle = random.nextDouble() * 2 * pi;
  double distance = random.nextDouble();
  return Offset(
    cos(angle) * distance * 0.9,
    sin(angle) * distance * 0.9,
  );
}

double calculateDistance(Offset a, Offset b) {
  return (a - b).distance;
}

Mood findClosestMood(Offset offset) {
  if (offset == Offset.zero) {
    return Mood.none;
  }
  Mood closestMood = Mood.values.first;
  double minDistance = double.infinity;

  for (var mood in Mood.values) {
    if (mood == Mood.none) {
      continue;
    }
    final moodOffset = getMoodOffset(mood);
    final distance = calculateDistance(offset, moodOffset);
    if (distance < minDistance) {
      minDistance = distance;
      closestMood = mood;
    }
  }

  return closestMood;
}

MoodEntry randomMoodEntry(DateTime date) {
  Offset offset = randomOffset();
  Mood closestMood = findClosestMood(offset);
  return MoodEntry(
    date: date,
    offset: offset,
    closestMood: closestMood,
  );
}

List<MoodEntry> generateMoodEntries({
  required DateTime startDate,
  required int days,
}) {
  List<MoodEntry> entries = [];
  for (int i = 0; i < days; i++) {
    entries.add(randomMoodEntry(startDate.add(Duration(days: i))));
  }
  return entries;
}
