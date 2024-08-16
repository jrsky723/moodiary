import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/add_diary/models/add_diary_model.dart';
import 'package:moodiary/features/add_diary/repos/add_diary_repo.dart';

class AddDiaryViewModel extends Notifier<AddDiaryModel> {
  final AddDiaryRepository _repository;

  AddDiaryViewModel(this._repository);

  void setContent(String value) {
    _repository.setContent(value);
    state = AddDiaryModel(
      images: state.images,
      content: value,
    );
  }

  void setImages(List<String> value) {
    _repository.setImages(value);
    state = AddDiaryModel(
      images: value,
      content: state.content,
    );
  }

  @override
  AddDiaryModel build() {
    return AddDiaryModel(
      images: _repository.getImages(),
      content: _repository.getContent(),
    );
  }
}

final addDiaryViewModelProvider =
    NotifierProvider<AddDiaryViewModel, AddDiaryModel>(
  () => throw UnimplementedError(),
);
