class UserProfileModel {
  final String uid;
  final String username;
  final String nickname;
  final String bio;
  final bool hasAvatar;

  UserProfileModel({
    required this.uid,
    required this.username,
    required this.nickname,
    required this.bio,
    required this.hasAvatar,
  });

  UserProfileModel.empty()
      : uid = '',
        username = '',
        nickname = '',
        bio = '',
        hasAvatar = false;

  UserProfileModel.fromJson(Map<String, dynamic> data)
      : uid = data['uid'],
        username = data['username'],
        nickname = data['nickname'],
        bio = data['bio'],
        hasAvatar = data['hasAvatar'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'nickname': nickname,
      'bio': bio,
      'hasAvatar': hasAvatar,
    };
  }

  UserProfileModel copyWith({
    String? uid,
    String? username,
    String? nickname,
    String? bio,
    bool? hasAvatar,
    String? avatarUrl,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      nickname: nickname ?? this.nickname,
      bio: bio ?? this.bio,
      hasAvatar: hasAvatar ?? this.hasAvatar,
    );
  }
}
