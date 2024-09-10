class UserProfileModel {
  final String uid;
  final String userName;
  final String name;
  final String bio;
  final bool hasAvatar;
  final String avatarUrl;

  UserProfileModel({
    required this.uid,
    required this.userName,
    required this.name,
    required this.bio,
    required this.hasAvatar,
    required this.avatarUrl,
  });

  UserProfileModel.empty()
      : uid = '',
        userName = '',
        name = '',
        bio = '',
        avatarUrl = '',
        hasAvatar = false;
}
