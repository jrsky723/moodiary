import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/add_diary/models/add_diary_model.dart';
import 'package:moodiary/features/add_diary/repos/add_diary_repo.dart';

class AddDiaryViewModel extends Notifier<AddDiaryModel> {
  final AddDiaryRepository _repository;

  AddDiaryViewModel(this._repository);

  void setContent(String value) {
    _repository.setContent(value);
    state = AddDiaryModel(
      date: state.date,
      content: value,
      images: state.images,
      isShared: state.isShared,
    );
  }

  void setImages(List<File> value) {
    _repository.setImagesPath(value);
    state = AddDiaryModel(
      date: state.date,
      content: state.content,
      images: value,
      isShared: state.isShared,
    );
  }

  void setIsShared(bool value) {
    _repository.setIsShared(value);
    state = AddDiaryModel(
      date: state.date,
      content: state.content,
      images: state.images,
      isShared: value,
    );
  }

  void setDate(String value) {
    _repository.setDate(value);
    state = AddDiaryModel(
      date: value,
      content: state.content,
      images: state.images,
      isShared: state.isShared,
    );
  }

  void saveDiary(
      String date, String content, List<File> images, bool isShared) {
    _repository.setDate(date);
    _repository.setContent(content);
    _repository.setImagesPath(images);
    _repository.setIsShared(isShared);

    state = AddDiaryModel(
      date: date,
      content: content,
      images: images,
      isShared: isShared,
    );
  }

  @override
  AddDiaryModel build() {
    return AddDiaryModel(
      date: _repository.getDate(),
      images: _repository.getImages(),
      content: _repository.getContent(),
      isShared: _repository.isShared(),
    );
  }
}

final addDiaryProvider = NotifierProvider<AddDiaryViewModel, AddDiaryModel>(
  () => throw UnimplementedError(),
);
