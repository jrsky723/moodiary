import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/diary/models/diary_model.dart';
import 'package:moodiary/features/diary/repos/diary_repo.dart';

// class AddDiaryViewModel extends Notifier<DiaryModel> {
//   final AddDiaryRepository _repository;

//   AddDiaryViewModel(this._repository);

//   void saveDiary(String content, List<File> photos, bool isPublic) {
//     _repository.postDiary(
//       DiaryModel(
//         content: content,
//         photos: photos,
//         isPublic: isPublic,
//       ),
//     );
//   }

//   @override
//   DiaryModel build() {
//     return DiaryModel();
//   }
// }

class AddDiaryViewModel extends AsyncNotifier<void> {
  late final DiaryRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(diaryRepo);
    return DiaryModel.empty();
  }

  Future<void> createDiary(DiaryModel model) async {
    state = const AsyncValue.loading();

    final diaryId = _repository.generateDiaryId(model.uid);

    final diary = DiaryModel(
      uid: model.uid,
      diaryId: diaryId,
      content: model.content,
      imageUrls: model.imageUrls,
      isPublic: model.isPublic,
      date: model.date,
    );

    await _repository.createDiary(diary.toJson());
    state = AsyncValue.data(diary);
  }
}

final addDiaryProvider = AsyncNotifierProvider<AddDiaryViewModel, void>(
  () => AddDiaryViewModel(),
);
