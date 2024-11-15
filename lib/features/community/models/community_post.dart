import 'package:moodiary/features/users/models/user_profile_model.dart';

class CommunityPost {
  final UserProfileModel owner;
  final String content;
  final List<String> imageUrls;
  final DateTime createdAt;

  const CommunityPost({
    required this.owner,
    required this.content,
    required this.imageUrls,
    required this.createdAt,
  });

  factory CommunityPost.fromJson(Map<String, dynamic> json) {
    final owner = UserProfileModel.fromJson(json['owner']);
    final diary = json['diary'];
    final content = diary['content'];
    final imageUrls = diary['images'].map<String>((image) {
      return image['url'] as String;
    }).toList();
    return CommunityPost(
      owner: owner,
      content: content,
      imageUrls: imageUrls,
      createdAt: DateTime.parse(diary['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'owner': owner.toJson(),
      'content': content,
      'imageUrls': imageUrls,
      'createdAt': createdAt,
    };
  }
}
