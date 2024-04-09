import 'package:flutter/material.dart';

enum Mood {
  veryHappy,
  happy,
  neutral,
  sad,
  verySad,
}

extension MoodExtension on Mood {
  String get label {
    switch (this) {
      case Mood.veryHappy:
        return "매우 행복함";
      case Mood.happy:
        return "행복함";
      case Mood.neutral:
        return "보통";
      case Mood.sad:
        return "슬픔";
      case Mood.verySad:
        return "매우 슬픔";
      default:
        return "알 수 없음";
    }
  }

  int get score {
    switch (this) {
      case Mood.veryHappy:
        return 5;
      case Mood.happy:
        return 4;
      case Mood.neutral:
        return 3;
      case Mood.sad:
        return 2;
      case Mood.verySad:
        return 1;
      default:
        return 0;
    }
  }

  Color get color {
    switch (this) {
      case Mood.veryHappy:
        return const Color(0xFF1FBF88);
      case Mood.happy:
        return const Color(0xFF26A69A);
      case Mood.neutral:
        return const Color(0xFF4DB6AC);
      case Mood.sad:
        return const Color(0xFF80CBC4);
      case Mood.verySad:
        return const Color(0xFFB2DFDB);
      default:
        return Colors.black;
    }
  }

  static Mood fromIndex(int index) {
    return Mood.values[index];
  }
}
