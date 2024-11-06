import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/community/models/community_post.dart';
import 'package:moodiary/features/community/repos/community_post_repo.dart';
import 'package:moodiary/features/diary/models/diary_model.dart';
import 'package:moodiary/features/diary/repos/diary_repo.dart';
import 'package:moodiary/features/users/models/user_profile_model.dart';

class AddDiaryViewModel extends AsyncNotifier<void> {
  late final DiaryRepository _Repo;
  late final CommunityPostRepo _communityPostRepo;
  @override
  FutureOr<void> build() {
    _Repo = ref.read(diaryRepo);
    _communityPostRepo = ref.read(communityPostRepo);
  }

  Future<void> createDiary({
    required String content,
    required List<File> images,
    required bool isPublic,
    required DateTime date,
  }) async {
    state = const AsyncValue.loading();

    final user = ref.read(authRepo).user;
    final userId = user?.uid;
    final diaryId = _Repo.generateDiaryId(userId!);

    final imageUrls = await _Repo.uploadImages(
      uid: userId,
      diaryId: diaryId,
      images: images,
    );

    final diary = DiaryModel(
      uid: userId,
      content: content,
      imageUrls: imageUrls,
      isPublic: isPublic,
      date: date,
      createdTime: DateTime.now(),
    );

    await _Repo.createDiary(diary);

    if (isPublic) {
      // userprofile model과 diary를 연결해서, communityPost 객체로 만들어서, communityPostRepo에 저장

      final user = UserProfileModel.empty();
      final communityPost = CommunityPost(
        date: date,
        owner: user,
        content: content,
        imageUrls: imageUrls,
        createdTime: DateTime.now(),
      );

      await _communityPostRepo.uploadPost(
        post: communityPost,
        diaryId: diaryId,
      );
    }
  }

  Future<DiaryModel?> fetchDiaryByDate(DateTime date) async {
    final user = ref.read(authRepo).user;
    final uid = user?.uid;
    final result = await _Repo.fetchDiariesByUserAndDateRange(
      uid: uid!,
      start: date,
      end: date,
    );
    if (result.docs.isEmpty) {
      return null;
    }
    final diary = DiaryModel.fromJson(json: result.docs.first.data());
    return diary;
  }
}

final addDiaryProvider = AsyncNotifierProvider<AddDiaryViewModel, void>(
  () => AddDiaryViewModel(),
);
