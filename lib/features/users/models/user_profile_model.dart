class UserProfileModel {
  final String uid;
  final String username;
  final String nickname;
  final String bio;
  final bool hasAvatar;
  final String avatarUrl;

  UserProfileModel({
    required this.uid,
    required this.username,
    required this.nickname,
    required this.bio,
    required this.hasAvatar,
    required this.avatarUrl,
  });

  UserProfileModel.empty()
      : uid = '',
        username = '',
        nickname = '',
        bio = '',
        avatarUrl = '',
        hasAvatar = false;

  UserProfileModel.fromJson(Map<String, dynamic> data)
      : uid = data['uid'],
        username = data['username'],
        nickname = data['name'],
        bio = data['bio'],
        avatarUrl = data['avatarUrl'],
        hasAvatar = data['hasAvatar'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'nickname': nickname,
      'bio': bio,
      'avatarUrl': avatarUrl,
      'hasAvatar': hasAvatar,
    };
  }
}
