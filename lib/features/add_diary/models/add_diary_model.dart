// class AddDiaryModel {
//   String content;
//   List<File> photos;
//   bool isPublic;

//   AddDiaryModel({
//     this.content = '',
//     this.photos = const [],
//     this.isPublic = true,
//   });

//   factory AddDiaryModel.fromJson(Map<String, dynamic> json) {
//     return AddDiaryModel(
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

class AddDiaryModel {
  final String uid;
  final String diaryId;
  final String content;
  final List<String> imageUrls;
  final bool isPublic;
  final String date;
  final double xOffset;
  final double yOffset;

  AddDiaryModel({
    required this.uid,
    this.diaryId = "0",
    required this.content,
    required this.imageUrls,
    required this.isPublic,
    required this.date,
    this.xOffset = 0.0,
    this.yOffset = 0.0,
  });

  AddDiaryModel.empty()
      : uid = '',
        diaryId = '',
        content = '',
        imageUrls = [],
        isPublic = true,
        date = '',
        xOffset = 0.0,
        yOffset = 0.0;
}
