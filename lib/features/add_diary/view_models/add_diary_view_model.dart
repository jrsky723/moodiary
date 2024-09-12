import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/add_diary/models/add_diary_model.dart';
import 'package:moodiary/features/add_diary/repos/add_diary_repo.dart';

class AddDiaryViewModel extends Notifier<AddDiaryModel> {
  final AddDiaryRepository _repository;

  AddDiaryViewModel(this._repository);

  void saveDiary(String content, List<File> photos, bool isPublic) {
    _repository.postDiary(
      AddDiaryModel(
        content: content,
        photos: photos,
        isPublic: isPublic,
      ),
    );
  }

  @override
  AddDiaryModel build() {
    return AddDiaryModel();
  }
}

final addDiaryProvider = NotifierProvider<AddDiaryViewModel, AddDiaryModel>(
  () => throw UnimplementedError(),
);
