class UserProfileModel {
  final String uid;
  final String userName;
  final String name;
  final String bio;
  final bool hasAvatar;

  UserProfileModel({
    required this.uid,
    required this.userName,
    required this.name,
    required this.bio,
    required this.hasAvatar,
  });

  UserProfileModel.empty()
      : uid = '',
        userName = '',
        name = '',
        bio = '',
        hasAvatar = false;
}
