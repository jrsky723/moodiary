// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ko';

  static String m0(label) => "가장 많이 기록한 감정: ${label}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "calendar": MessageLookupByLibrary.simpleMessage("달력"),
        "cancelBtn": MessageLookupByLibrary.simpleMessage("취소"),
        "confirmBtn": MessageLookupByLibrary.simpleMessage("확인"),
        "darkModeSubtitle": MessageLookupByLibrary.simpleMessage("어두운 모드로 전환"),
        "darkModeTitle": MessageLookupByLibrary.simpleMessage("다크 모드"),
        "diarySearchHint": MessageLookupByLibrary.simpleMessage("다이어리 검색"),
        "englishModeSubtitle":
            MessageLookupByLibrary.simpleMessage("언어를 영어로 전환합니다."),
        "englishModeTitle": MessageLookupByLibrary.simpleMessage("영어 모드"),
        "happy": MessageLookupByLibrary.simpleMessage("행복함"),
        "monthlyMoodDistTitle":
            MessageLookupByLibrary.simpleMessage("월간 기분 분포"),
        "monthlyMoodFlowTitle":
            MessageLookupByLibrary.simpleMessage("월간 기분 흐름"),
        "monthlyTab": MessageLookupByLibrary.simpleMessage("월간"),
        "montlyDateSelectTitle": MessageLookupByLibrary.simpleMessage("월 선택하기"),
        "mostFrequentMoodText": m0,
        "normal": MessageLookupByLibrary.simpleMessage("보통"),
        "sad": MessageLookupByLibrary.simpleMessage("슬픔"),
        "selectMonthYear": MessageLookupByLibrary.simpleMessage("연도 및 월 선택"),
        "settings": MessageLookupByLibrary.simpleMessage("설정"),
        "unknown": MessageLookupByLibrary.simpleMessage("알 수 없음"),
        "veryHappy": MessageLookupByLibrary.simpleMessage("매우 행복함"),
        "verySad": MessageLookupByLibrary.simpleMessage("매우 슬픔"),
        "yearlyDateSelectTitle":
            MessageLookupByLibrary.simpleMessage("연도 선택하기"),
        "yearlyMoodDistTitle": MessageLookupByLibrary.simpleMessage("연간 기분 분포"),
        "yearlyMoodFlowTitle": MessageLookupByLibrary.simpleMessage("연간 기분 흐름"),
        "yearlyTab": MessageLookupByLibrary.simpleMessage("연간")
      };
}
