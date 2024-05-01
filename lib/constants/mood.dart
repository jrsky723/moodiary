import 'package:flutter/material.dart';
import 'package:moodiary/generated/l10n.dart';

enum Mood {
  veryHappy,
  happy,
  neutral,
  sad,
  verySad,
}

extension MoodExtension on Mood {
  String label(BuildContext context) {
    switch (this) {
      case Mood.veryHappy:
        return S.of(context).veryHappy;
      case Mood.happy:
        return S.of(context).happy;
      case Mood.neutral:
        return S.of(context).normal;
      case Mood.sad:
        return S.of(context).sad;
      case Mood.verySad:
        return S.of(context).verySad;
      default:
        return S.of(context).unknown;
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
  // from methods

  static Mood fromScore(int score) {
    switch (score) {
      case 5:
        return Mood.veryHappy;
      case 4:
        return Mood.happy;
      case 3:
        return Mood.neutral;
      case 2:
        return Mood.sad;
      case 1:
        return Mood.verySad;
      default:
        return Mood.neutral;
    }
  }
}
