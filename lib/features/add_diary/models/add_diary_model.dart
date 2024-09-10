import 'dart:io';

class AddDiaryModel {
  String content;
  List<File> images;

  AddDiaryModel({
    this.content = '',
    this.images = const [],
  });

  factory AddDiaryModel.fromJson(Map<String, dynamic> json) {
    return AddDiaryModel(
      content: json['content'],
      images: List<File>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'images': images.map((image) => image.path).toList(),
    };
  }
}
