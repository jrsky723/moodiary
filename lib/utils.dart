import 'dart:math';

import 'package:moodiary/constants/mood.dart';
import 'package:moodiary/features/dashboard/models/mood_entry.dart';

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
