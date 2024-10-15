import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/diary/models/diary_model.dart';
import 'package:moodiary/features/diary/repos/diary_repo.dart';

class UserPostsViewModel extends AsyncNotifier<List<DiaryModel>> {
  late final DiaryRepository _diaryRepo;
  late List<DiaryModel> _list;

  @override
  FutureOr<List<DiaryModel>> build() async {
    _diaryRepo = ref.read(diaryRepo);

    _list = await _fetchUserPosts();
    return _list;
  }

  Future<List<DiaryModel>> _fetchUserPosts() async {
    final user = ref.read(authRepo).user;
    final uid = user?.uid;

    final diariesData = await _diaryRepo.fetchDiariesByUId(uid!);
    final diaries = diariesData.docs.map(
      (doc) => DiaryModel.fromJson(
        json: doc.data(),
      ),
    );
    return diaries.toList();
  }
}

final userPostProvider =
    AsyncNotifierProvider<UserPostsViewModel, List<DiaryModel>>(
  () => UserPostsViewModel(),
);
