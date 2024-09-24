import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/diary/models/diary_model.dart';
import 'package:moodiary/features/diary/repos/diary_repo.dart';

// class DiaryDetailViewModel extends AsyncNotifier<DiaryModel> {
//   late final DiaryRepository _repository;
//   final String uid = '1';

//   @override
//   Future<DiaryModel> build(String date) async {
//     _repository = ref.read(diaryRepo);

//     final diary = await _repository.getDiaryByDate(uid, date);
//     return diary ?? DiaryModel.empty();
//   }
// }

class DiaryDetailViewModel extends AsyncNotifier<DiaryModel> {
  late final DiaryRepository _repository;

  DiaryModel diary = DiaryModel.empty();

  final String uid = '1';

  @override
  FutureOr<DiaryModel> build() async {
    return diary;
  }

  Future<void> getDiaryByDate(String date) async {
    state = const AsyncValue.loading();

    _repository = ref.read(diaryRepo);

    final data = await _repository.getDiaryByDate(uid, date);
    if (data != null) {
      diary = DiaryModel.fromJson(data);
      state = AsyncValue.data(diary);
    } else {
      state = AsyncValue.data(diary);
    }
  }

  Future<List<String>> getImageUrls(List<String> imagePaths) async {
    List<String> imageUrls = [];
    for (int i = 0; i < imagePaths.length; i++) {
      imageUrls.add(await _repository.getImageUrl(imagePaths[i]));
    }
    return imageUrls;
  }
}

final diaryDetailProvider =
    AsyncNotifierProvider<DiaryDetailViewModel, DiaryModel>(
  () => DiaryDetailViewModel(),
);
