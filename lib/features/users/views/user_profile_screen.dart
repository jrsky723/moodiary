import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/settings/views/settings_screen.dart';
import 'package:moodiary/features/users/models/user_profile_model.dart';
import 'package:moodiary/features/users/view_models/user_profile_view_model.dart';
import 'package:moodiary/features/users/views/profile_edit_screen.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  late final List<Map<String, dynamic>> _posts;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(usersProvider.notifier).fetchUserPosts().then((value) {
        setState(() {
          _posts = value;
        });
      });
    });
  }

  void _onEditProfile(UserProfileModel user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfileEditScreen(
          userProfile: user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
          loading: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
          error: (error, stackTrace) => Scaffold(
            body: Center(
              child: Text('Error: $error'),
            ),
          ),
          data: (data) => Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              title: Text(data.username),
              actions: [
                if (data.uid == ref.watch(authRepo).user!.uid) ...[
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
                    onPressed: () => _onEditProfile(data),
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
                        data.hasAvatar
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  "https://firebasestorage.googleapis.com/v0/b/moodiary-b37ca.appspot.com/o/avatars%2F${data.uid}?alt=media&test=${DateTime.now().millisecondsSinceEpoch}",
                                ), // Example URL, replace with actual avatar URL
                              )
                            : CircleAvatar(
                                radius: 50,
                                child: Text(
                                  data.nickname[0],
                                  style: const TextStyle(fontSize: 40),
                                ),
                              ),
                        Gaps.v16,
                        Text(
                          data.nickname,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Gaps.v16,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size16,
                          ),
                          child: Text(
                            data.bio,
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      ref.read(usersProvider.notifier).fetchUserPosts();

                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(_posts[index]['imageUrl']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
