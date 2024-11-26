import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

  void _onUserPostTap(int index, String username) {
    // 사용자의 게시물을 탭했을 때, 해당 위치 (인덱스정보)를 전달하고,
    // 사용자의 게시물 화면으로 이동
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UserPostsScreen(
          index: index,
          username: username,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final uid = ref.read(authRepo).user!.uid;

    final avatarUrl = dotenv.env['AVATAR_URL']!
        .replaceAll('{uid}', uid)
        .replaceAll(
            '{timestamp}', DateTime.now().millisecondsSinceEpoch.toString());

    final userProfileState = ref.watch(userProfileProvider);
    return Scaffold(
      appBar: AppBar(
        title: userProfileState.when(
          loading: () => const Text('Loading...'),
          error: (error, stackTrace) => const Text('Error'),
          data: (user) => Text(user.username),
        ),
        actions: [
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
          userProfileState.when(
            loading: () => const SizedBox.shrink(),
            error: (error, stackTrace) => const SizedBox.shrink(),
            data: (user) {
              if (user.uid == ref.read(authRepo).user!.uid) {
                return IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _onEditProfile(user),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
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
                    data: (user) {
                      return Center(
                        child: Column(
                          children: <Widget>[
                            user.hasAvatar
                                ? CircleAvatar(
                                    radius: 50,
                                    foregroundImage: NetworkImage(
                                      avatarUrl,
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    child: Text(
                                      user.username == ''
                                          ? 'U'
                                          : user.username[0],
                                      style: const TextStyle(fontSize: 40),
                                    ),
                                  ),
                            Gaps.v16,
                            Text(
                              user.nickname == '' ? 'undefined' : user.nickname,
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
                      );
                    },
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
                          onTap: () => _onUserPostTap(
                              index, posts[index].owner.username),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    posts[index].imageUrls.isEmpty
                                        ? 'https://via.placeholder.com/150'
                                        : posts[index].imageUrls[0]),
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
