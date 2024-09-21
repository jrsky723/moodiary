import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/add_diary/models/add_diary_model.dart';
import 'package:moodiary/features/add_diary/repos/add_diary_repo.dart';

// class AddDiaryViewModel extends Notifier<AddDiaryModel> {
//   final AddDiaryRepository _repository;

//   AddDiaryViewModel(this._repository);

//   void saveDiary(String content, List<File> photos, bool isPublic) {
//     _repository.postDiary(
//       AddDiaryModel(
//         content: content,
//         photos: photos,
//         isPublic: isPublic,
//       ),
//     );
//   }

//   @override
//   AddDiaryModel build() {
//     return AddDiaryModel();
//   }
// }

class AddDiaryViewModel extends AsyncNotifier<void> {
  late final AddDiaryRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(addDiaryRepo);
    return AddDiaryModel.empty();
  }

  Future<void> createDiary(AddDiaryModel model) async {
    await Future.delayed(const Duration(seconds: 5));
    state = const AsyncValue.loading();
    final diary = AddDiaryModel(
      uid: model.uid,
      diaryId: model.diaryId,
      content: model.content,
      imageUrls: model.imageUrls,
      isPublic: model.isPublic,
    );
    await _repository.createDiary(diary);
  }
}

final addDiaryProvider = AsyncNotifierProvider<AddDiaryViewModel, void>(
  () => AddDiaryViewModel(),
);
