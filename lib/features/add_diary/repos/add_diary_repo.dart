// 데이터 유지및 데이터 가져오기만 하는 클래스
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class AddDiaryRepository {
  static const String _date = 'date';
  static const String _content = 'content';
  static const String _images = 'images';
  static const String _isShared = 'isShared';

  final SharedPreferences _prefs;

  AddDiaryRepository(this._prefs);

  Future<void> setContent(String content) async {
    await _prefs.setString(_content, content);
  }

  Future<void> setImagesPath(List<File> images) async {
    List<String> base64Images = [];

    for (File image in images) {
      base64Images.add(image.path);
    }

    await _prefs.setStringList(_images, base64Images);
  }

  Future<void> setIsShared(bool isShared) async {
    await _prefs.setBool(_isShared, isShared);
  }

  Future<void> setDate(String date) async {
    await _prefs.setString(_date, date);
  }

  String getContent() {
    return _prefs.getString(_content) ?? '';
  }

  List<File> getImages() {
    List<String> base64Images = _prefs.getStringList(_images) ?? [];
    List<File> images = [];
    for (String base64Image in base64Images) {
      images.add(File(base64Image));
    }
    return images;
  }

  bool isShared() {
    return _prefs.getBool(_isShared) ?? false;
  }

  String getDate() {
    return _prefs.getString(_date) ?? '';
  }
}
