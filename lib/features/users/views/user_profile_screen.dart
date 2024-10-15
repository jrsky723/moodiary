import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/settings/views/settings_screen.dart';
import 'package:moodiary/features/users/models/user_profile_model.dart';
import 'package:moodiary/features/users/view_models/user_posts_view_model.dart';
import 'package:moodiary/features/users/view_models/user_profile_view_model.dart';
import 'package:moodiary/features/users/views/profile_edit_screen.dart';
import 'package:moodiary/features/users/views/user_posts_screen.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});
  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onEditProfile(UserProfileModel user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfileEditScreen(
          userProfile: user,
        ),
      ),
    );
  }

  Future<void> _onRefresh() {
    return ref.read(userPostsProvider.notifier).refresh();
  }

  void _onUserPostTap(int index) {
    // 사용자의 게시물을 탭했을 때, 해당 위치 (인덱스정보)를 전달하고,
    // 사용자의 게시물 화면으로 이동
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UserPostsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ref.watch(userProfileProvider).when(
            loading: () => AppBar(
              title: const Text('Loading...'),
            ),
            error: (error, stackTrace) => AppBar(
              title: Text('Error: $error'),
            ),
            data: (user) => AppBar(
              surfaceTintColor: Colors.transparent,
              title: Text(user.username),
              actions: [
                if (user.uid == ref.watch(authRepo).user!.uid) ...[
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
                    onPressed: () => _onEditProfile(user),
                  ),
                ]
              ],
            ),
          ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ref.watch(userProfileProvider).when(
                    loading: () => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    error: (error, stackTrace) => Center(
                      child: Text('Error: $error'),
                    ),
                    data: (user) => Center(
                      child: Column(
                        children: <Widget>[
                          user.hasAvatar
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                    "https://firebasestorage.googleapis.com/v0/b/moodiary-b37ca.appspot.com/o/avatars%2F${user.uid}?alt=media&test=${DateTime.now().millisecondsSinceEpoch}",
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  child: Text(
                                    user.nickname[0],
                                    style: const TextStyle(fontSize: 40),
                                  ),
                                ),
                          Gaps.v16,
                          Text(
                            user.nickname,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Gaps.v16,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size16,
                            ),
                            child: Text(
                              user.bio,
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
                  ),
              ref.watch(userPostsProvider).when(
                    loading: () => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    error: (error, stackTrace) => Center(
                      child: Text('Error: $error'),
                    ),
                    data: (posts) => GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _onUserPostTap(index),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(posts[index].imageUrls[0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
