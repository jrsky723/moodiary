// class DiaryModel {
//   String content;
//   List<File> photos;
//   bool isPublic;

//   DiaryModel({
//     this.content = '',
//     this.photos = const [],
//     this.isPublic = true,
//   });

//   factory DiaryModel.fromJson(Map<String, dynamic> json) {
//     return DiaryModel(
//       content: json['content'],
//       photos: List<File>.from(json['photos']),
//       isPublic: json['is_public'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'author_id': 1,
//       'content': content,
//       'photos': photos.map((image) => image.path).toList(),
//       'is_public': isPublic,
//     };
//   }
// }

class DiaryModel {
  final String uid;
  final String diaryId;
  final String content;
  List<String> imageUrls;
  final bool isPublic;
  final DateTime date;
  final double xOffset;
  final double yOffset;
  final int createAt;
  final int updateAt;

  DiaryModel({
    required this.uid,
    this.diaryId = "0",
    required this.content,
    required this.imageUrls,
    required this.isPublic,
    required this.date,
    this.xOffset = 0.0,
    this.yOffset = 0.0,
    this.createAt = 0,
    this.updateAt = 0,
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
        createAt = 0,
        updateAt = 0;

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
      'createAt': createAt,
      'updateAt': updateAt,
    };
  }

  DiaryModel.fromJson(Map<String, dynamic> data)
      : uid = data['uid'],
        diaryId = data['diaryId'],
        content = data['content'],
        imageUrls = data['imageUrls'],
        isPublic = data['isPublic'],
        date = data['date'],
        xOffset = data['xOffset'],
        yOffset = data['yOffset'],
        createAt = data['createAt'],
        updateAt = data['updateAt'];
}
