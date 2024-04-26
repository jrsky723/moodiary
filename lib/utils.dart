import 'dart:math';

import 'package:moodiary/constants/mood.dart';
import 'package:moodiary/features/dashboard/models/mood_entry.dart';

import 'package:flutter/material.dart';

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

Random random = Random();

MoodEntry randomMoodEntry(DateTime date) {
  return MoodEntry(
    date: date,
    mood: Mood.values[random.nextInt(Mood.values.length)],
  );
}

List<MoodEntry> generateMoodEntries(DateTime startDate, int days) {
  List<MoodEntry> entries = [];
  for (int i = 0; i < days; i++) {
    entries.add(randomMoodEntry(startDate.add(Duration(days: i))));
  }
  return entries;
}

int daysInMonth(int year, int month) {
  // 0 is the day before the first day of the month
  return DateTime(year, month + 1, 0).day;
}

int daysInYear(int year) {
  DateTime firstDay = DateTime(year, 1, 1);
  DateTime lastDay = DateTime(year + 1, 1, 1);
  return lastDay.difference(firstDay).inDays;
}

List<MoodEntry> modeYearlyMoodEntries(
  List<MoodEntry> moodEntries,
) {
  final List<MoodEntry> monthlyMoodModes = [];
  // 매달 기분 점수 최빈값 계산, 예상 리스트 아이템 수 12

  int year = moodEntries[0].date.year;

  final Map<int, List<Mood>> monthMoods = {
    for (int i = 1; i <= 12; i++) i: [],
  };

  for (final moodEntry in moodEntries) {
    int month = moodEntry.date.month;
    monthMoods[month]!.add(moodEntry.mood);
  }

  for (int i = 1; i <= 12; i++) {
    final Map<Mood, int> frequencyMap = {};
    for (var mood in monthMoods[i]!) {
      frequencyMap[mood] = (frequencyMap[mood] ?? 0) + 1;
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

    monthlyMoodModes.add(MoodEntry(
      date: DateTime(year, i),
      mood: mostFrequentMood,
    ));
  }
  return monthlyMoodModes;
}

bool isDarkMode(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}
