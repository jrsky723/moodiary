class CalendarEntry {
  // 캘린더의 각 항목을 나타내는 클래스
  // 1. 날짜, 2. 일기가 작성되어있는지 여부, 3.일기의 대표 이미지(썸네일) url 4. communitry 공개 여부
  final DateTime date;
  final bool hasDiary;
  final bool isPublic;
  final bool isAnalyzed;
  final int? diaryId;
  final String? thumbnailUrl;

  CalendarEntry({
    required this.date,
    required this.hasDiary,
    required this.isPublic,
    required this.isAnalyzed,
    this.diaryId,
    this.thumbnailUrl,
  });

  CalendarEntry.empty({required this.date})
      : hasDiary = false,
        isPublic = false,
        isAnalyzed = false,
        thumbnailUrl = null,
        diaryId = null;

  CalendarEntry.fromJson({required Map<String, dynamic> json})
      : // iso8601 포맷의 문자열을 DateTime으로 변환
        date = DateTime.parse(json['createdAt']),
        diaryId = json['diaryId'],
        hasDiary = true,
        isPublic = json['isPublic'],
        isAnalyzed = json['isAnalyzed'],
        thumbnailUrl =
            json['images'].isNotEmpty ? json['images'][0]['url'] : null;
}
