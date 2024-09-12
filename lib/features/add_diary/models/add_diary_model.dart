import 'dart:io';

class AddDiaryModel {
  String content;
  List<File> photos;
  bool isPublic;

  AddDiaryModel({
    this.content = '',
    this.photos = const [],
    this.isPublic = true,
  });

  factory AddDiaryModel.fromJson(Map<String, dynamic> json) {
    return AddDiaryModel(
      content: json['content'],
      photos: List<File>.from(json['photos']),
      isPublic: json['is_public'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author_id': 1,
      'content': content,
      'photos': photos.map((image) => image.path).toList(),
      'is_public': isPublic,
    };
  }
}
