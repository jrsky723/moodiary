import 'package:flutter/material.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/settings/views/settings_screen.dart';
import 'package:moodiary/features/users/models/user_profile_model.dart';
import 'package:moodiary/features/users/views/profile_edit_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final UserProfileModel _userProfile = UserProfileModel(
    uid: '123456',
    username: 'Hong111',
    bio: '안녕하세요! 저는 홍길동입니다. 저는 개발밖에 안해요',
    hasAvatar: false,
    avatarUrl: 'https://picsum.photos/id/${123456}/200/200',
    nickname: '홍길동',
  );

  final bool _isMyProfile = true;
  final List<String> _posts = List.generate(
      20,
      (index) =>
          'https://picsum.photos/id/${index + 1}/200/200'); // 예제 이미지 URL 리스트

  void _onEditProfile() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ProfileEditScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(_userProfile.username),
        actions: [
          if (_isMyProfile) ...[
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _onEditProfile,
            ),
          ]
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  _userProfile.hasAvatar
                      ? const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://via.placeholder.com/150',
                          ), // Example URL, replace with actual avatar URL
                        )
                      : CircleAvatar(
                          radius: 50,
                          child: Text(
                            _userProfile.nickname[0],
                            style: const TextStyle(fontSize: 40),
                          ),
                        ),
                  Gaps.v16,
                  Text(
                    _userProfile.nickname,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Gaps.v16,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size16,
                    ),
                    child: Text(
                      _userProfile.bio,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ),
                  Gaps.v16,
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(_posts[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
