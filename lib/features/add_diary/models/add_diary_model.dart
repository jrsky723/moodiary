// 이미지와 내용을 가지고 있는 Diary 모델
// 이미지는 여러개가 있고 내용은 하나이다.

import 'dart:io';

class AddDiaryModel {
  String date;
  String content;
  List<File> images;
  bool isShared;

  AddDiaryModel({
    this.date = "date",
    this.images = const [],
    this.content = 'content',
    this.isShared = false,
  });

  // diary 내용을 json으로 받아서 Diary 객체로 만들어준다.
  // factory가 생성자를 사용해서 return 할 수 있도록 해준다.

  // factory AddDiaryModel.fromJson(Map<String, dynamic> json) {
  //   return AddDiaryModel(
  //     date: json['date'],
  //     images: List<String>.from(json['images']),
  //     content: json['content'],
  //     isShared: json['isShared'],
  //   );
  // }
}
