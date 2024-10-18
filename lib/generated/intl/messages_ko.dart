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

  static String m0(days) => "전체 중 ${days}개의 감정정보만 표시됩니다";

  static String m1(value) => "${value}일";

  static String m2(label) => "가장 많이 기록한 감정: ${label}";

  static String m3(date) => "선택한 날짜: ${date}";

  static String m4(hours, minutes) => "수면시간 ${hours}시간 ${minutes}분";

  static String m5(username) => "${username}님 당신의 메일과 비밀번호를 작성해주세요";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "OneImageMustBeKept":
            MessageLookupByLibrary.simpleMessage("최소 하나의 이미지를 유지해야 합니다"),
        "active": MessageLookupByLibrary.simpleMessage("활동"),
        "activeness": MessageLookupByLibrary.simpleMessage("활발"),
        "alarmed": MessageLookupByLibrary.simpleMessage("(나쁜) 놀란"),
        "alert": MessageLookupByLibrary.simpleMessage("(좋은) 놀란"),
        "appDiscription": MessageLookupByLibrary.simpleMessage("감정 분석 일기앱"),
        "bedtime": MessageLookupByLibrary.simpleMessage("취침"),
        "bio": MessageLookupByLibrary.simpleMessage("소개"),
        "bored": MessageLookupByLibrary.simpleMessage("지루한"),
        "calendar": MessageLookupByLibrary.simpleMessage("달력"),
        "cancel": MessageLookupByLibrary.simpleMessage("취소"),
        "cancelBtn": MessageLookupByLibrary.simpleMessage("취소"),
        "cantAccessFutureDiary":
            MessageLookupByLibrary.simpleMessage("미래의 일기는 접근할 수 없습니다"),
        "circumplexModel":
            MessageLookupByLibrary.simpleMessage("Circumplex Model"),
        "communityBtn": MessageLookupByLibrary.simpleMessage("커뮤니티"),
        "communityBtnSubtitle":
            MessageLookupByLibrary.simpleMessage("커뮤니티에 올리기"),
        "communityTitle": MessageLookupByLibrary.simpleMessage("이야기"),
        "completeBtn": MessageLookupByLibrary.simpleMessage("완료"),
        "confirmBtn": MessageLookupByLibrary.simpleMessage("확인"),
        "content": MessageLookupByLibrary.simpleMessage("만족한"),
        "createProfile": MessageLookupByLibrary.simpleMessage("프로필 생성"),
        "darkModeSubtitle": MessageLookupByLibrary.simpleMessage("어두운 모드로 전환"),
        "darkModeTitle": MessageLookupByLibrary.simpleMessage("다크 모드"),
        "dashboard": MessageLookupByLibrary.simpleMessage("분석"),
        "dashboardDescription": m0,
        "days": m1,
        "delete": MessageLookupByLibrary.simpleMessage("삭제"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("계정 삭제"),
        "deleteAccountMessage":
            MessageLookupByLibrary.simpleMessage("정말 계정을 삭제하시겠습니까?"),
        "deleteDiary": MessageLookupByLibrary.simpleMessage("일기 삭제"),
        "deleteDiaryErrorMessage":
            MessageLookupByLibrary.simpleMessage("다이어리 삭제 중 오류가 발생했습니다"),
        "deleteDiaryMessage":
            MessageLookupByLibrary.simpleMessage("정말 지우시겠습니까?"),
        "deleteDiarySuccessMessage":
            MessageLookupByLibrary.simpleMessage("다이어리가 성공적으로 삭제되었습니다"),
        "delighted": MessageLookupByLibrary.simpleMessage("즐거운"),
        "diary": MessageLookupByLibrary.simpleMessage("일기"),
        "diaryContent": MessageLookupByLibrary.simpleMessage("일기 내용"),
        "diarySearchHint": MessageLookupByLibrary.simpleMessage("다이어리 검색"),
        "distressed": MessageLookupByLibrary.simpleMessage("괴로운"),
        "doYouHaveAccount":
            MessageLookupByLibrary.simpleMessage("이미 계정이 없으신가요?  "),
        "doYouHaveAnAccountAlready":
            MessageLookupByLibrary.simpleMessage("이미 계정이 있으신가요?  "),
        "editDiary": MessageLookupByLibrary.simpleMessage("일기 수정"),
        "editProfile": MessageLookupByLibrary.simpleMessage("프로필 수정"),
        "email": MessageLookupByLibrary.simpleMessage("이메일"),
        "emailAndPasswordAreNotValid":
            MessageLookupByLibrary.simpleMessage("이메일과 비밀번호가 유효하지 않습니다"),
        "emailNotValid": MessageLookupByLibrary.simpleMessage("이메일 형태가 아닙니다"),
        "emotion": MessageLookupByLibrary.simpleMessage("감정"),
        "englishModeSubtitle":
            MessageLookupByLibrary.simpleMessage("언어를 영어로 전환합니다"),
        "englishModeTitle": MessageLookupByLibrary.simpleMessage("영어 모드"),
        "enterContentPrompt":
            MessageLookupByLibrary.simpleMessage("내용을 입력해주세요"),
        "enterYourDiaryContent":
            MessageLookupByLibrary.simpleMessage("일기 내용을 입력해주세요"),
        "excited": MessageLookupByLibrary.simpleMessage("신난"),
        "fetchDataError":
            MessageLookupByLibrary.simpleMessage("데이터를 가져오는 중 오류가 발생했습니다"),
        "glad": MessageLookupByLibrary.simpleMessage("기쁜"),
        "gloomy": MessageLookupByLibrary.simpleMessage("우울한"),
        "gotoLogin": MessageLookupByLibrary.simpleMessage("로그인하기"),
        "gotoSignUp": MessageLookupByLibrary.simpleMessage("회원가입하기"),
        "happiness": MessageLookupByLibrary.simpleMessage("행복"),
        "hour": MessageLookupByLibrary.simpleMessage("시"),
        "howWasYourDay": MessageLookupByLibrary.simpleMessage("어떤 하루였나요?"),
        "images": MessageLookupByLibrary.simpleMessage("이미지"),
        "login": MessageLookupByLibrary.simpleMessage("로그인"),
        "minute": MessageLookupByLibrary.simpleMessage("분"),
        "miserable": MessageLookupByLibrary.simpleMessage("비참한"),
        "monthlyMoodDistTitle":
            MessageLookupByLibrary.simpleMessage("월간 기분 분포"),
        "monthlyMoodFlowTitle":
            MessageLookupByLibrary.simpleMessage("월간 기분 흐름"),
        "monthlyTab": MessageLookupByLibrary.simpleMessage("월간"),
        "moodAnalysis": MessageLookupByLibrary.simpleMessage("감정 분석"),
        "moodAnalysisExplanation":
            MessageLookupByLibrary.simpleMessage("오늘의 감정을 분석한 결과입니다"),
        "moodCloud": MessageLookupByLibrary.simpleMessage("감정 구름"),
        "moodDistribution": MessageLookupByLibrary.simpleMessage("감정 분포"),
        "mostFrequentMoodText": m2,
        "negative": MessageLookupByLibrary.simpleMessage("부정"),
        "neutral": MessageLookupByLibrary.simpleMessage("중립"),
        "nextBtn": MessageLookupByLibrary.simpleMessage("다음"),
        "nickBioDiscription":
            MessageLookupByLibrary.simpleMessage("나중에 변경할 수 있습니다"),
        "nickname": MessageLookupByLibrary.simpleMessage("닉네임"),
        "nicknameValidError":
            MessageLookupByLibrary.simpleMessage("닉네임은 3자 이상이어야 합니다"),
        "noData": MessageLookupByLibrary.simpleMessage("데이터가 없습니다."),
        "noImagesAvailable": MessageLookupByLibrary.simpleMessage("이미지가 없습니다"),
        "passive": MessageLookupByLibrary.simpleMessage("수동"),
        "password": MessageLookupByLibrary.simpleMessage("비밀번호"),
        "person": MessageLookupByLibrary.simpleMessage("사람"),
        "pleaseEnterName": MessageLookupByLibrary.simpleMessage("이름을 입력해주세요."),
        "pleaseEnterSomeContent":
            MessageLookupByLibrary.simpleMessage("내용을 입력해주세요"),
        "pleaseWriteDiaryOrAddPhoto":
            MessageLookupByLibrary.simpleMessage("일기를 작성하거나 사진을 추가해주세요"),
        "positive": MessageLookupByLibrary.simpleMessage("긍정"),
        "pwdlengtherror":
            MessageLookupByLibrary.simpleMessage("비밀번호는 8자에서 20자 사이여야 합니다"),
        "pwdnumbererror":
            MessageLookupByLibrary.simpleMessage("비밀번호는 최소 하나의 숫자를 포함해야 합니다"),
        "pwdspecialcharerror":
            MessageLookupByLibrary.simpleMessage("비밀번호는 최소 하나의 특수문자를 포함해야 합니다"),
        "pwduppercaseerror":
            MessageLookupByLibrary.simpleMessage("비밀번호는 최소 하나의 대문자를 포함해야 합니다"),
        "relaxed": MessageLookupByLibrary.simpleMessage("이완된"),
        "resetToDefaultProfile":
            MessageLookupByLibrary.simpleMessage("기본 프로필로 변경"),
        "save": MessageLookupByLibrary.simpleMessage("저장"),
        "scrollToTop": MessageLookupByLibrary.simpleMessage("맨위로"),
        "seeMore": MessageLookupByLibrary.simpleMessage("더보기"),
        "selectDate": MessageLookupByLibrary.simpleMessage("날짜 선택"),
        "selectFromGallery": MessageLookupByLibrary.simpleMessage("갤러리에서 선택"),
        "selectMonthDay": MessageLookupByLibrary.simpleMessage("월 및 일 선택"),
        "selectMonthYear": MessageLookupByLibrary.simpleMessage("연도 및 월 선택"),
        "selectPhotoPrompt": MessageLookupByLibrary.simpleMessage("사진을 선택해주세요"),
        "selectedDate": m3,
        "serene": MessageLookupByLibrary.simpleMessage("평온한"),
        "settings": MessageLookupByLibrary.simpleMessage("설정"),
        "signOut": MessageLookupByLibrary.simpleMessage("로그아웃"),
        "signUp": MessageLookupByLibrary.simpleMessage("회원가입"),
        "sleep": MessageLookupByLibrary.simpleMessage("수면"),
        "sleepDuration": m4,
        "sleepiness": MessageLookupByLibrary.simpleMessage("졸림"),
        "sleepy": MessageLookupByLibrary.simpleMessage("졸린"),
        "submit": MessageLookupByLibrary.simpleMessage("저장"),
        "takePhoto": MessageLookupByLibrary.simpleMessage("사진 촬영"),
        "tense": MessageLookupByLibrary.simpleMessage("긴장된"),
        "textSave": MessageLookupByLibrary.simpleMessage("저장"),
        "thisIsFutureDiary": MessageLookupByLibrary.simpleMessage("미래날짜입니다."),
        "tired": MessageLookupByLibrary.simpleMessage("지친"),
        "todaysPhoto": MessageLookupByLibrary.simpleMessage("오늘의 사진"),
        "unhappiness": MessageLookupByLibrary.simpleMessage("불행"),
        "unknown": MessageLookupByLibrary.simpleMessage("알 수 없음"),
        "upset": MessageLookupByLibrary.simpleMessage("속상한"),
        "userName": MessageLookupByLibrary.simpleMessage("사용자 이름"),
        "userNameMinError":
            MessageLookupByLibrary.simpleMessage("사용자 이름은 2자 이상이어야 합니다"),
        "usernameDiscription":
            MessageLookupByLibrary.simpleMessage("나중에 변경할 수 없습니다"),
        "usernameTitle": m5,
        "wakeUpTime": MessageLookupByLibrary.simpleMessage("기상"),
        "yearlyDateSelectTitle":
            MessageLookupByLibrary.simpleMessage("연도 선택하기"),
        "yearlyMoodDistTitle": MessageLookupByLibrary.simpleMessage("연간 기분 분포"),
        "yearlyMoodFlowTitle": MessageLookupByLibrary.simpleMessage("연간 기분 흐름"),
        "yearlyTab": MessageLookupByLibrary.simpleMessage("연간")
      };
}
