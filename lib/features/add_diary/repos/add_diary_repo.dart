// 데이터 유지및 데이터 가져오기만 하는 클래스
import 'package:shared_preferences/shared_preferences.dart';

class AddDiaryRepository {
  static const String _content = 'content';
  static const String _images = 'images';

  final SharedPreferences _prefs;

  AddDiaryRepository(this._prefs);

  Future<void> setContent(String content) async {
    await _prefs.setString(_content, content);
  }

  Future<void> setImages(List<String> images) async {
    await _prefs.setStringList(_images, images);
  }

  String getContent() {
    return _prefs.getString(_content) ?? '';
  }

  List<String> getImages() {
    return _prefs.getStringList(_images) ?? [];
  }
}
