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
  late final DiaryRepository _diaryRepo;
  late final CommunityPostRepo _communityPostRepo;
  @override
  FutureOr<void> build() {
    _diaryRepo = ref.read(diaryRepo);
    _communityPostRepo = ref.read(communityPostRepo);
    return DiaryModel.empty();
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
    final diaryId = _diaryRepo.generateDiaryId(userId!);

    final imageUrls = await _diaryRepo.uploadImages(
      uid: userId,
      diaryId: diaryId,
      images: images,
    );

    final diary = DiaryModel(
      uid: userId,
      diaryId: diaryId,
      content: content,
      imageUrls: imageUrls,
      isPublic: isPublic,
      date: date,
      createAt: DateTime.now().millisecondsSinceEpoch,
      updateAt: DateTime.now().millisecondsSinceEpoch,
    );

    await _diaryRepo.createDiary(diary);

    if (isPublic) {
      // userprofile model과 diary를 연결해서, communityPost 객체로 만들어서, communityPostRepo에 저장

      // final user = await _communityPostRepo.getUserProfile(userId);
      final user = UserProfileModel.empty();
      final communityPost = CommunityPost(
        date: date,
        owner: user,
        content: content,
        imageUrls: imageUrls,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      await _communityPostRepo.uploadPost(
        post: communityPost,
        diaryId: diaryId,
      );
    }

    state = AsyncValue.data(diary);
  }
}

final addDiaryProvider = AsyncNotifierProvider<AddDiaryViewModel, void>(
  () => AddDiaryViewModel(),
);
