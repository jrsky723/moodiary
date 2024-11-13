import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/community/models/community_post.dart';
import 'package:moodiary/features/diary/models/diary_model.dart';
import 'package:moodiary/features/diary/repos/diary_repo.dart';
import 'package:moodiary/features/users/models/user_profile_model.dart';
import 'package:moodiary/features/users/repos/user_repo.dart';

class UserPostsViewModel extends AutoDisposeAsyncNotifier<List<CommunityPost>> {
  late final DiaryRepository _diaryRepo;
  late final UserRepository _userRepo;
  late List<CommunityPost> _list;
  late UserProfileModel _user;

  @override
  FutureOr<List<CommunityPost>> build() async {
    _diaryRepo = ref.read(diaryRepo);
    _userRepo = ref.read(userRepo);
    final user = ref.read(authRepo).user;
    final profile = await _userRepo.findProfile(user!.uid);
    if (profile != null) {
      _user = UserProfileModel.fromJson(profile);
    } else {
      _user = UserProfileModel.empty();
    }
    _list = await _fetchUserPosts(_user.uid);
    return _list;
  }

  Future<List<CommunityPost>> _fetchUserPosts(String uid) async {
    final diariesData = await _diaryRepo.fetchDiariesByUid(uid);
    final diaries = diariesData.map(
      (json) {
        final diary = DiaryModel.fromJson(json: json);
        return CommunityPost(
          date: diary.date,
          owner: _user,
          content: diary.content,
          imageUrls: diary.imageUrls,
          createdTime: diary.date,
        );
      },
    );
    return diaries.toList();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final posts = await _fetchUserPosts(_user.uid);
    _list = posts;
    state = AsyncValue.data(_list);
  }
}

final userPostsProvider =
    AutoDisposeAsyncNotifierProvider<UserPostsViewModel, List<CommunityPost>>(
  () => UserPostsViewModel(),
);
