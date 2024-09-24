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

  Future<void> createDiary({
    required String content,
    required List<String> imageUrls,
    required bool isPublic,
    required DateTime date,
  }) async {
    state = const AsyncValue.loading();

    const userId = '1'; // TODO: authentication 구성하고 uid로 변경해야됨
    final diaryId = _repository.generateDiaryId(userId);

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

    await _repository.createDiary(diary);
    state = AsyncValue.data(diary);
  }
}

final addDiaryProvider = AsyncNotifierProvider<AddDiaryViewModel, void>(
  () => AddDiaryViewModel(),
);
