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

  static String m0(value) => "${value}일";

  static String m1(label) => "가장 많이 기록한 감정: ${label}";

  static String m2(days) => "최근 ${days}일 감정";

  static String m3(hours, minutes) => "수면시간 ${hours}시간 ${minutes}분";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "active": MessageLookupByLibrary.simpleMessage("활동"),
        "activeness": MessageLookupByLibrary.simpleMessage("활발"),
        "alarmed": MessageLookupByLibrary.simpleMessage("(나쁜) 놀란"),
        "alert": MessageLookupByLibrary.simpleMessage("(좋은) 놀란"),
        "bedtime": MessageLookupByLibrary.simpleMessage("취침"),
        "bored": MessageLookupByLibrary.simpleMessage("지루한"),
        "calendar": MessageLookupByLibrary.simpleMessage("달력"),
        "cancelBtn": MessageLookupByLibrary.simpleMessage("취소"),
        "circumplexModel":
            MessageLookupByLibrary.simpleMessage("Circumplex Model"),
        "communityTitle": MessageLookupByLibrary.simpleMessage("이야기"),
        "confirmBtn": MessageLookupByLibrary.simpleMessage("확인"),
        "content": MessageLookupByLibrary.simpleMessage("만족한"),
        "darkModeSubtitle": MessageLookupByLibrary.simpleMessage("어두운 모드로 전환"),
        "darkModeTitle": MessageLookupByLibrary.simpleMessage("다크 모드"),
        "dashboard": MessageLookupByLibrary.simpleMessage("분석"),
        "days": m0,
        "delighted": MessageLookupByLibrary.simpleMessage("즐거운"),
        "diary": MessageLookupByLibrary.simpleMessage("일기"),
        "diarySearchHint": MessageLookupByLibrary.simpleMessage("다이어리 검색"),
        "distressed": MessageLookupByLibrary.simpleMessage("괴로운"),
        "emotion": MessageLookupByLibrary.simpleMessage("감정"),
        "englishModeSubtitle":
            MessageLookupByLibrary.simpleMessage("언어를 영어로 전환합니다."),
        "englishModeTitle": MessageLookupByLibrary.simpleMessage("영어 모드"),
        "enterContentPrompt":
            MessageLookupByLibrary.simpleMessage("내용을 입력해주세요"),
        "excited": MessageLookupByLibrary.simpleMessage("신난"),
        "glad": MessageLookupByLibrary.simpleMessage("기쁜"),
        "gloomy": MessageLookupByLibrary.simpleMessage("우울한"),
        "happiness": MessageLookupByLibrary.simpleMessage("행복"),
        "howWasYourDay": MessageLookupByLibrary.simpleMessage("어떤 하루였나요?"),
        "miserable": MessageLookupByLibrary.simpleMessage("비참한"),
        "monthlyMoodDistTitle":
            MessageLookupByLibrary.simpleMessage("월간 기분 분포"),
        "monthlyMoodFlowTitle":
            MessageLookupByLibrary.simpleMessage("월간 기분 흐름"),
        "monthlyTab": MessageLookupByLibrary.simpleMessage("월간"),
        "montlyDateSelectTitle": MessageLookupByLibrary.simpleMessage("월 선택하기"),
        "moodAnalysis": MessageLookupByLibrary.simpleMessage("감정 분석"),
        "moodAnalysisExplanation":
            MessageLookupByLibrary.simpleMessage("오늘의 감정을 분석한 결과입니다."),
        "moodCloud": MessageLookupByLibrary.simpleMessage("감정 구름"),
        "moodDistribution": MessageLookupByLibrary.simpleMessage("감정 분포"),
        "mostFrequentMoodText": m1,
        "negative": MessageLookupByLibrary.simpleMessage("부정"),
        "neutral": MessageLookupByLibrary.simpleMessage("어중간한"),
        "passive": MessageLookupByLibrary.simpleMessage("수동"),
        "person": MessageLookupByLibrary.simpleMessage("사람"),
        "positive": MessageLookupByLibrary.simpleMessage("긍정"),
        "recentMoodDescription": m2,
        "relaxed": MessageLookupByLibrary.simpleMessage("이완된"),
        "scrollToTop": MessageLookupByLibrary.simpleMessage("맨위로"),
        "selectMonthDay": MessageLookupByLibrary.simpleMessage("월 및 일 선택"),
        "selectMonthYear": MessageLookupByLibrary.simpleMessage("연도 및 월 선택"),
        "selectPhotoPrompt": MessageLookupByLibrary.simpleMessage("사진을 선택해주세요"),
        "serene": MessageLookupByLibrary.simpleMessage("평온한"),
        "settings": MessageLookupByLibrary.simpleMessage("설정"),
        "sleep": MessageLookupByLibrary.simpleMessage("수면"),
        "sleepDuration": m3,
        "sleepiness": MessageLookupByLibrary.simpleMessage("졸림"),
        "sleepy": MessageLookupByLibrary.simpleMessage("졸린"),
        "tense": MessageLookupByLibrary.simpleMessage("긴장된"),
        "tired": MessageLookupByLibrary.simpleMessage("지친"),
        "todaysPhoto": MessageLookupByLibrary.simpleMessage("오늘의 사진"),
        "unhappiness": MessageLookupByLibrary.simpleMessage("불행"),
        "unknown": MessageLookupByLibrary.simpleMessage("알 수 없음"),
        "upset": MessageLookupByLibrary.simpleMessage("속상한"),
        "wakeUpTime": MessageLookupByLibrary.simpleMessage("기상"),
        "yearlyDateSelectTitle":
            MessageLookupByLibrary.simpleMessage("연도 선택하기"),
        "yearlyMoodDistTitle": MessageLookupByLibrary.simpleMessage("연간 기분 분포"),
        "yearlyMoodFlowTitle": MessageLookupByLibrary.simpleMessage("연간 기분 흐름"),
        "yearlyTab": MessageLookupByLibrary.simpleMessage("연간")
      };
}
