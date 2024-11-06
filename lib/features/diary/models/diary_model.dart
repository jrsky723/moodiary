class DiaryModel {
  final String uid;
  final int diaryId;
  final String content;
  List<String> imageUrls;
  final bool isPublic;
  final DateTime date;
  final double xOffset;
  final double yOffset;
  final DateTime createdTime;

  DiaryModel({
    required this.uid,
    this.diaryId = 0,
    required this.content,
    required this.imageUrls,
    required this.isPublic,
    required this.date,
    this.xOffset = 0.0,
    this.yOffset = 0.0,
    required this.createdTime,
  });

  DiaryModel.empty()
      : uid = '',
        diaryId = 0,
        content = '',
        imageUrls = [],
        isPublic = true,
        date = DateTime.now(),
        xOffset = 0.0,
        yOffset = 0.0,
        createdTime = DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'diaryId': diaryId,
      'content': content,
      'imageUrls': imageUrls,
      'isPublic': isPublic,
      'date': date,
      'xOffset': xOffset,
      'yOffset': yOffset,
      'createdTime': createdTime,
    };
  }

  DiaryModel.fromJson({
    required Map<String, dynamic> json,
  })  : uid = json['uid'],
        diaryId = json['diaryId'],
        content = json['content'],
        // List<Map<String, dynamic>> 을 List<String>으로 변환
        imageUrls = List<Map<String, dynamic>>.from(json['imageUrls'])
            .map((e) => e['url'] as String)
            .toList(),
        isPublic = json['public'],
        // timestamp를 DateTime으로 변환
        // json['createdDate']가 String type(2024-11-05)이면, 아래와 같이 변환
        date = DateTime.parse(json['createdDate']),
        // date = DateTime.fromMillisecondsSinceEpoch(
        //   (json['createdDate'] as Timestamp).millisecondsSinceEpoch,
        // ),
        xOffset = json['offsetX'],
        yOffset = json['offsetY'],
        createdTime =
            DateTime.parse(json['createdDate'] + ' ' + json['createdTime']);

  DiaryModel copyWith({
    String? content,
    List<String>? imageUrls,
    bool? isPublic,
    DateTime? date,
    double? xOffset,
    double? yOffset,
    DateTime? createdTime,
  }) {
    return DiaryModel(
      uid: uid,
      diaryId: diaryId,
      content: content ?? this.content,
      imageUrls: imageUrls ?? this.imageUrls,
      isPublic: isPublic ?? this.isPublic,
      date: date ?? this.date,
      xOffset: xOffset ?? this.xOffset,
      yOffset: yOffset ?? this.yOffset,
      createdTime: createdTime ?? this.createdTime,
    );
  }
}
