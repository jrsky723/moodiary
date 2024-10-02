import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarEntry {
  // 캘린더의 각 항목을 나타내는 클래스
  // 1. 날짜, 2. 일기가 작성되어있는지 여부, 3.일기의 대표 이미지(썸네일) url 4. communitry 공개 여부
  final DateTime date;
  final bool hasDiary;
  final bool isPublic;
  final String? diaryId;
  final String? thumbnailUrl;

  CalendarEntry({
    required this.date,
    required this.hasDiary,
    required this.isPublic,
    this.diaryId,
    this.thumbnailUrl,
  });

  CalendarEntry.empty({required this.date})
      : hasDiary = false,
        isPublic = false,
        thumbnailUrl = null,
        diaryId = null;

  CalendarEntry.fromJson({required Map<String, dynamic> json})
      : // timestamp를 DateTime으로 변환
        date = DateTime.fromMillisecondsSinceEpoch(
            (json['date'] as Timestamp).millisecondsSinceEpoch),
        diaryId = json['diaryId'],
        hasDiary = true,
        isPublic = json['isPublic'],
        thumbnailUrl =
            json['imageUrls'].isNotEmpty ? json['imageUrls'][0] : null;
}
