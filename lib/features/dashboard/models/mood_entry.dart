import 'package:flutter/material.dart';
import 'package:moodiary/constants/mood.dart';

class MoodEntry {
  final DateTime date;
  final Offset offset;
  final Mood closestMood;

  MoodEntry({
    required this.date,
    required this.offset,
    required this.closestMood,
  });
}
