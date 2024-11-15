import 'package:flutter/material.dart';
import 'package:moodiary/constants/mood.dart';
import 'package:moodiary/utils/mood_utils.dart';

class MoodEntry {
  final DateTime date;
  final Offset offset;
  final Mood closestMood;

  MoodEntry({
    required this.date,
    required this.offset,
    required this.closestMood,
  });

  MoodEntry.fromJson(Map<String, dynamic> json)
      : // datetime parse
        date = DateTime.parse(json['createdAt']),
        offset = Offset(json['offsetX'], json['offsetY']),
        closestMood = findClosestMood(Offset(json['offsetX'], json['offsetY']));
}
