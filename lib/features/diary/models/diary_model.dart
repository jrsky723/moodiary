class DiaryModel {
  final String uid;
  final int diaryId;
  final String content;
  List<String> imageUrls;
  final bool isPublic;
  final bool isAnalyzed;
  final DateTime date;
  final double offsetX;
  final double offsetY;

  DiaryModel({
    required this.uid,
    this.diaryId = 0,
    required this.content,
    required this.imageUrls,
    required this.isPublic,
    required this.isAnalyzed,
    required this.date,
    this.offsetX = 0.0,
    this.offsetY = 0.0,
  });

  DiaryModel.empty()
      : uid = '',
        diaryId = 0,
        content = '',
        imageUrls = [],
        isPublic = false,
        isAnalyzed = false,
        date = DateTime.now(),
        offsetX = 0.0,
        offsetY = 0.0;

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'diaryId': diaryId,
      'content': content,
      'imageUrls': imageUrls,
      'isPublic': isPublic,
      'isAnalyzed': isAnalyzed,
      'date': date.toIso8601String(),
      'offsetX': offsetX,
      'offsetY': offsetY,
    };
  }

  DiaryModel.fromJson({
    required Map<String, dynamic> json,
  })  : uid = json['uid'],
        diaryId = json['diaryId'],
        content = json['content'],
        // List<Map<String, dynamic>> 을 List<String>으로 변환
        imageUrls = json['images'].map<String>((image) {
          return image['url'].toString();
        }).toList(),
        isPublic = json['isPublic'],
        isAnalyzed = json['isAnalyzed'],
        // timestamp를 DateTime으로 변환
        // json['createdDate']가 String type(2024-11-05)이면, 아래와 같이 변환
        date = DateTime.parse(json['createdAt']),
        // date = DateTime.fromMillisecondsSinceEpoch(
        //   (json['createdDate'] as Timestamp).millisecondsSinceEpoch,
        // ),
        offsetX = json['offsetX'],
        offsetY = json['offsetY'];

  DiaryModel copyWith({
    String? content,
    List<String>? imageUrls,
    bool? isPublic,
    bool? isAnalyzed,
    DateTime? date,
    double? xOffset,
    double? yOffset,
  }) {
    return DiaryModel(
      uid: uid,
      diaryId: diaryId,
      content: content ?? this.content,
      imageUrls: imageUrls ?? this.imageUrls,
      isPublic: isPublic ?? this.isPublic,
      isAnalyzed: isAnalyzed ?? this.isAnalyzed,
      date: date ?? this.date,
      offsetX: xOffset ?? offsetX,
      offsetY: yOffset ?? offsetY,
    );
  }
}
