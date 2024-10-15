import 'package:cloud_firestore/cloud_firestore.dart';

class DiaryModel {
  final String uid;
  final String diaryId;
  final String content;
  List<String> imageUrls;
  final bool isPublic;
  final DateTime date;
  final double xOffset;
  final double yOffset;
  final int createdAt;

  DiaryModel({
    required this.uid,
    this.diaryId = "0",
    required this.content,
    required this.imageUrls,
    required this.isPublic,
    required this.date,
    this.xOffset = 0.0,
    this.yOffset = 0.0,
    this.createdAt = 0,
  });

  DiaryModel.empty()
      : uid = '',
        diaryId = '',
        content = '',
        imageUrls = [],
        isPublic = true,
        date = DateTime.now(),
        xOffset = 0.0,
        yOffset = 0.0,
        createdAt = 0;

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
      'createdAt': createdAt,
    };
  }

  DiaryModel.fromJson({
    required Map<String, dynamic> json,
  })  : uid = json['uid'],
        diaryId = json['diaryId'],
        content = json['content'],
        // List<dynamic>를 List<String>으로 변환
        imageUrls = List<String>.from(json['imageUrls']),
        isPublic = json['isPublic'],
        // timestamp를 DateTime으로 변환
        date = DateTime.fromMillisecondsSinceEpoch(
          (json['date'] as Timestamp).millisecondsSinceEpoch,
        ),
        xOffset = json['xOffset'],
        yOffset = json['yOffset'],
        createdAt = json['createdAt'];

  DiaryModel copyWith({
    String? content,
    List<String>? imageUrls,
    bool? isPublic,
    DateTime? date,
    double? xOffset,
    double? yOffset,
    int? createdAt,
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
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
