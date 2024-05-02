class SettingsModel {
  bool isDarkMode;
  bool isEnglish;

  SettingsModel({
    this.isDarkMode = false,
    this.isEnglish = true,
  });

  SettingsModel copyWith({
    bool? isDarkMode,
    bool? isEnglish,
  }) {
    return SettingsModel(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isEnglish: isEnglish ?? this.isEnglish,
    );
  }
}
