import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepos {
  static const String _isDarkMode = 'isDarkMode';
  static const String _isEnglish = 'isEnglish';

  final SharedPreferences _prefs;

  SettingsRepos(this._prefs);

  Future<void> setDarkMode(bool value) async {
    await _prefs.setBool(_isDarkMode, value);
  }

  Future<void> setEnglish(bool value) async {
    await _prefs.setBool(_isEnglish, value);
  }

  bool isDarkMode() {
    return _prefs.getBool(_isDarkMode) ?? false;
  }

  bool isEnglish() {
    return _prefs.getBool(_isEnglish) ?? false;
  }
}
