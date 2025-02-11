import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/diary/models/diary_model.dart';
import 'package:moodiary/features/diary/repos/diary_repo.dart';

class AddDiaryViewModel extends AsyncNotifier<void> {
  late final DiaryRepository _repo;

  @override
  FutureOr<void> build() {
    _repo = ref.read(diaryRepo);
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

    final imageUrls = await _repo.uploadImages(
      uid: userId!,
      images: images,
    );

    final diary = DiaryModel(
      uid: userId,
      content: content,
      imageUrls: imageUrls,
      isPublic: isPublic,
      isAnalyzed: false,
      date: date,
    );
    try {
      await _repo.createDiary(diary);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<DiaryModel?> fetchDiaryByDate(DateTime date) async {
    final user = ref.read(authRepo).user;
    final uid = user?.uid;
    final result = await _repo.fetchDiaryByDate(uid!, date);
    if (result == null) {
      return null;
    }
    final diary = DiaryModel.fromJson(json: result);
    return diary;
  }
}

final addDiaryProvider = AsyncNotifierProvider<AddDiaryViewModel, void>(
  () => AddDiaryViewModel(),
);
