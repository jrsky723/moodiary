class DiaryEntry {
  final String title; // 일기 제목
  final String description; // 일기의 내용 일부 (최대 30자), 길이는 추후 변경 가능
  final String date; // 일기 작성 날짜 (yyyy-MM-dd)
  final String? imageUrl; // 일기에 첨부된 이미지 URL, 저화질 이미지 사용

  DiaryEntry({
    required this.title,
    required this.description,
    required this.date,
    this.imageUrl,
  });
}
