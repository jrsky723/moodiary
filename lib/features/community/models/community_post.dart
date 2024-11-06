import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moodiary/features/users/models/user_profile_model.dart';

class CommunityPost {
  final DateTime date;
  final UserProfileModel owner;
  final String content;
  final List<String> imageUrls;
  final DateTime createdTime;

  const CommunityPost({
    required this.date,
    required this.owner,
    required this.content,
    required this.imageUrls,
    required this.createdTime,
  });

  CommunityPost.fromJson({
    required Map<String, dynamic> json,
  })  :
        // TimeStamp를 DateTime으로 변환
        date = DateTime.fromMillisecondsSinceEpoch(
            (json['date'] as Timestamp).millisecondsSinceEpoch),
        owner = UserProfileModel.fromJson(json['owner']),
        content = json['content'],
        imageUrls = List<String>.from(json['imageUrls']),
        createdTime = DateTime.fromMillisecondsSinceEpoch(
            (json['createdAt'] as Timestamp).millisecondsSinceEpoch);

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'owner': owner.toJson(),
      'content': content,
      'imageUrls': imageUrls,
      'createdTime': createdTime,
    };
  }
}
