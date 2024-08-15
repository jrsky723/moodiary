import 'package:flutter/material.dart';
import 'package:moodiary/features/add_diary/models/add_diary_model.dart';
import 'package:moodiary/features/add_diary/repos/add_diary_repo.dart';

class AddDiaryViewModel extends ChangeNotifier {
  final AddDiaryRepository _repository;

  late final AddDiaryModel _model = AddDiaryModel(
    images: _repository.getImages(),
    content: _repository.getContent(),
  );

  AddDiaryViewModel(this._repository);

  String get content => _model.content;
  List<String> get images => _model.images;

  void setContent(String value) {
    _repository.setContent(value);
    _model.content = value;
    notifyListeners();
  }

  void setImages(List<String> value) {
    _repository.setImages(value);
    _model.images = value;
    notifyListeners();
  }
}
