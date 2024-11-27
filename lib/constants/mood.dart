import 'package:flutter/material.dart';
import 'package:moodiary/generated/l10n.dart';

enum Mood {
  // Circumplex model 에서, (1,0)에서 반시계 방향으로
  glad,
  delighted,
  excited,
  alert,
  alarmed,
  tense,
  distressed,
  upset,
  miserable,
  gloomy,
  bored,
  tired,
  sleepy,
  relaxed,
  serene,
  content,
  none,
}

extension MoodExtension on Mood {
  String label(BuildContext context) {
    switch (this) {
      case Mood.glad:
        return S.of(context).glad;
      case Mood.delighted:
        return S.of(context).delighted;
      case Mood.excited:
        return S.of(context).excited;
      case Mood.alert:
        return S.of(context).alert;
      case Mood.alarmed:
        return S.of(context).alarmed;
      case Mood.tense:
        return S.of(context).tense;
      case Mood.distressed:
        return S.of(context).distressed;
      case Mood.upset:
        return S.of(context).upset;
      case Mood.miserable:
        return S.of(context).miserable;
      case Mood.gloomy:
        return S.of(context).gloomy;
      case Mood.bored:
        return S.of(context).bored;
      case Mood.tired:
        return S.of(context).tired;
      case Mood.sleepy:
        return S.of(context).sleepy;
      case Mood.relaxed:
        return S.of(context).relaxed;
      case Mood.serene:
        return S.of(context).serene;
      case Mood.content:
        return S.of(context).content;
      case Mood.none:
        return S.of(context).none;
    }
  }
}
