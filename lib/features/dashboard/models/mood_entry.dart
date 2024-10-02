import 'package:cloud_firestore/cloud_firestore.dart';
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

  MoodEntry.fromJson({
    required Map<String, dynamic> json,
  })  : // timestamp를 DateTime으로 변환
        date = DateTime.fromMillisecondsSinceEpoch(
            (json['date'] as Timestamp).millisecondsSinceEpoch),
        offset = Offset(json['xOffset'], json['yOffset']),
        closestMood = findClosestMood(Offset(json['xOffset'], json['yOffset']));
}
