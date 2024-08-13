import 'dart:io';

class DiaryModel {
  List<File>? images;
  String diary;

  DiaryModel({
    this.images,
    this.diary = '',
  });

  DiaryModel copyWith({
    List<File>? images,
    String? diary,
  }) {
    return DiaryModel(
      images: images ?? this.images,
      diary: diary ?? this.diary,
    );
  }
}
