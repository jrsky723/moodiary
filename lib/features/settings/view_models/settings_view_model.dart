import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/settings/models/settings_model.dart';
import 'package:moodiary/features/settings/repos/settings_repos.dart';

class SettingsViewModel extends Notifier<SettingsModel> {
  final SettingsRepos _repos;

  SettingsViewModel(this._repos);

  void setDarkMode(bool value) {
    _repos.setDarkMode(value);
    state = state.copyWith(isDarkMode: value);
  }

  void setEnglish(bool value) {
    _repos.setEnglish(value);
    state = state.copyWith(isEnglish: value);
  }

  @override
  SettingsModel build() {
    return SettingsModel(
      isDarkMode: _repos.isDarkMode(),
      isEnglish: _repos.isEnglish(),
    );
  }
}

final settingsProvider = NotifierProvider<SettingsViewModel, SettingsModel>(
  () => throw UnimplementedError(),
);
