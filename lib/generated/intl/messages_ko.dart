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

  static String m1(date) => "선택한 날짜: ${date}";

  static String m2(hours, minutes) => "수면시간 ${hours}시간 ${minutes}분";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alarmed": MessageLookupByLibrary.simpleMessage("(나쁜) 놀란"),
        "alert": MessageLookupByLibrary.simpleMessage("(좋은) 놀란"),
        "bedtime": MessageLookupByLibrary.simpleMessage("취침"),
        "bored": MessageLookupByLibrary.simpleMessage("지루한"),
        "calendar": MessageLookupByLibrary.simpleMessage("달력"),
        "cancelBtn": MessageLookupByLibrary.simpleMessage("취소"),
        "communityBtn": MessageLookupByLibrary.simpleMessage("커뮤니티"),
        "communityBtnSubtitle":
            MessageLookupByLibrary.simpleMessage("커뮤니티에 올리기"),
        "communityTitle": MessageLookupByLibrary.simpleMessage("이야기"),
        "confirmBtn": MessageLookupByLibrary.simpleMessage("확인"),
        "content": MessageLookupByLibrary.simpleMessage("만족한"),
        "darkModeSubtitle": MessageLookupByLibrary.simpleMessage("어두운 모드로 전환"),
        "darkModeTitle": MessageLookupByLibrary.simpleMessage("다크 모드"),
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
        "hour": MessageLookupByLibrary.simpleMessage("시"),
        "howWasYourDay": MessageLookupByLibrary.simpleMessage("어떤 하루였나요?"),
        "minute": MessageLookupByLibrary.simpleMessage("분"),
        "miserable": MessageLookupByLibrary.simpleMessage("비참한"),
        "monthlyMoodDistTitle":
            MessageLookupByLibrary.simpleMessage("월간 기분 분포"),
        "monthlyMoodFlowTitle":
            MessageLookupByLibrary.simpleMessage("월간 기분 흐름"),
        "monthlyTab": MessageLookupByLibrary.simpleMessage("월간"),
        "montlyDateSelectTitle": MessageLookupByLibrary.simpleMessage("월 선택하기"),
        "mostFrequentMoodText": m0,
        "person": MessageLookupByLibrary.simpleMessage("사람"),
        "relaxed": MessageLookupByLibrary.simpleMessage("이완된"),
        "save": MessageLookupByLibrary.simpleMessage("저장"),
        "scrollToTop": MessageLookupByLibrary.simpleMessage("맨위로"),
        "selectDate": MessageLookupByLibrary.simpleMessage("날짜 선택"),
        "selectMonthDay": MessageLookupByLibrary.simpleMessage("월 및 일 선택"),
        "selectMonthYear": MessageLookupByLibrary.simpleMessage("연도 및 월 선택"),
        "selectPhotoPrompt": MessageLookupByLibrary.simpleMessage("사진을 선택해주세요"),
        "selectedDate": m1,
        "serene": MessageLookupByLibrary.simpleMessage("평온한"),
        "settings": MessageLookupByLibrary.simpleMessage("설정"),
        "sleep": MessageLookupByLibrary.simpleMessage("수면"),
        "sleepDuration": m2,
        "sleepy": MessageLookupByLibrary.simpleMessage("졸린"),
        "tense": MessageLookupByLibrary.simpleMessage("긴장된"),
        "tired": MessageLookupByLibrary.simpleMessage("지친"),
        "todaysPhoto": MessageLookupByLibrary.simpleMessage("오늘의 사진"),
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
