import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/diary/models/diary_model.dart';
import 'package:moodiary/features/diary/repos/diary_repo.dart';

class DiaryViewModel extends FamilyAsyncNotifier<DiaryModel, String> {
  late final DiaryRepository _repo;
  late DiaryModel _diary;
  @override
  FutureOr<DiaryModel> build(String arg) async {
    _repo = ref.read(diaryRepo);
    _diary = await _fetchDiaryById(arg);
    return _diary;
  }

  Future<DiaryModel> _fetchDiaryById(String diaryId) async {
    final user = ref.read(authRepo).user;
    final uid = user?.uid;
    final result = await _repo.fetchDiaryByUserAndId(uid!, diaryId);
    if (result.docs.isEmpty) {
      throw Exception('Diary not found');
    }
    final diary = DiaryModel.fromJson(json: result.docs.first.data());
    return diary;
  }

  Future<void> updateDiary({
    required String diaryId,
    required String content,
    required List<String> imageUrls,
    required bool isPublic,
  }) async {
    state = const AsyncValue.loading();
    final user = ref.read(authRepo).user;
    final uid = user!.uid;
    await _repo.updateDiary(
      uid,
      diaryId,
      {
        'content': content,
        'imageUrls': imageUrls,
      },
    );
    if (isPublic) {
      await _repo.updateCommunityDiary(
        diaryId,
        {
          'content': content,
          'imageUrls': imageUrls,
        },
      );
    }
    _diary = _diary.copyWith(
      content: content,
      imageUrls: imageUrls,
    );
    state = AsyncValue.data(_diary);
  }

  Future<void> deleteDiary(String diaryId) async {
    state = const AsyncValue.loading();
    final uid = ref.read(authRepo).user!.uid;

    List<String> diaryIds = [diaryId];

    await _repo.deleteUserDiariesByDiaryIds(uid, diaryIds);
    await _repo.deleteCommunityDiariesByDiaryIds(diaryIds);
  }
}

final diaryProvider =
    AsyncNotifierProvider.family<DiaryViewModel, DiaryModel, String>(
  () => DiaryViewModel(),
);
