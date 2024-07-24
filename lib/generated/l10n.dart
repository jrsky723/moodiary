// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Calendar`
  String get calendar {
    return Intl.message(
      'Calendar',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `Select Month & Year`
  String get selectMonthYear {
    return Intl.message(
      'Select Month & Year',
      name: 'selectMonthYear',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelBtn {
    return Intl.message(
      'Cancel',
      name: 'cancelBtn',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirmBtn {
    return Intl.message(
      'Confirm',
      name: 'confirmBtn',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Change to dark mode`
  String get darkModeSubtitle {
    return Intl.message(
      'Change to dark mode',
      name: 'darkModeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get darkModeTitle {
    return Intl.message(
      'Dark mode',
      name: 'darkModeTitle',
      desc: '',
      args: [],
    );
  }

  /// `English Mode`
  String get englishModeTitle {
    return Intl.message(
      'English Mode',
      name: 'englishModeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Change the language to English`
  String get englishModeSubtitle {
    return Intl.message(
      'Change the language to English',
      name: 'englishModeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Diary Search`
  String get diarySearchHint {
    return Intl.message(
      'Diary Search',
      name: 'diarySearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthlyTab {
    return Intl.message(
      'Monthly',
      name: 'monthlyTab',
      desc: '',
      args: [],
    );
  }

  /// `Yearly`
  String get yearlyTab {
    return Intl.message(
      'Yearly',
      name: 'yearlyTab',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Mood Flow`
  String get monthlyMoodFlowTitle {
    return Intl.message(
      'Monthly Mood Flow',
      name: 'monthlyMoodFlowTitle',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Mood Distribution`
  String get monthlyMoodDistTitle {
    return Intl.message(
      'Monthly Mood Distribution',
      name: 'monthlyMoodDistTitle',
      desc: '',
      args: [],
    );
  }

  /// `Yearly Mood Flow`
  String get yearlyMoodFlowTitle {
    return Intl.message(
      'Yearly Mood Flow',
      name: 'yearlyMoodFlowTitle',
      desc: '',
      args: [],
    );
  }

  /// `Yearly Mood Distribution`
  String get yearlyMoodDistTitle {
    return Intl.message(
      'Yearly Mood Distribution',
      name: 'yearlyMoodDistTitle',
      desc: '',
      args: [],
    );
  }

  /// `Most frequently recorded emotion: {label}`
  String mostFrequentMoodText(Object label) {
    return Intl.message(
      'Most frequently recorded emotion: $label',
      name: 'mostFrequentMoodText',
      desc: '',
      args: [label],
    );
  }

  /// `Glad`
  String get glad {
    return Intl.message(
      'Glad',
      name: 'glad',
      desc: '',
      args: [],
    );
  }

  /// `Delighted`
  String get delighted {
    return Intl.message(
      'Delighted',
      name: 'delighted',
      desc: '',
      args: [],
    );
  }

  /// `Excited`
  String get excited {
    return Intl.message(
      'Excited',
      name: 'excited',
      desc: '',
      args: [],
    );
  }

  /// `Alert`
  String get alert {
    return Intl.message(
      'Alert',
      name: 'alert',
      desc: '',
      args: [],
    );
  }

  /// `Alarmed`
  String get alarmed {
    return Intl.message(
      'Alarmed',
      name: 'alarmed',
      desc: '',
      args: [],
    );
  }

  /// `Tense`
  String get tense {
    return Intl.message(
      'Tense',
      name: 'tense',
      desc: '',
      args: [],
    );
  }

  /// `Distressed`
  String get distressed {
    return Intl.message(
      'Distressed',
      name: 'distressed',
      desc: '',
      args: [],
    );
  }

  /// `Upset`
  String get upset {
    return Intl.message(
      'Upset',
      name: 'upset',
      desc: '',
      args: [],
    );
  }

  /// `Miserable`
  String get miserable {
    return Intl.message(
      'Miserable',
      name: 'miserable',
      desc: '',
      args: [],
    );
  }

  /// `Gloomy`
  String get gloomy {
    return Intl.message(
      'Gloomy',
      name: 'gloomy',
      desc: '',
      args: [],
    );
  }

  /// `Bored`
  String get bored {
    return Intl.message(
      'Bored',
      name: 'bored',
      desc: '',
      args: [],
    );
  }

  /// `Tired`
  String get tired {
    return Intl.message(
      'Tired',
      name: 'tired',
      desc: '',
      args: [],
    );
  }

  /// `Sleepy`
  String get sleepy {
    return Intl.message(
      'Sleepy',
      name: 'sleepy',
      desc: '',
      args: [],
    );
  }

  /// `Relaxed`
  String get relaxed {
    return Intl.message(
      'Relaxed',
      name: 'relaxed',
      desc: '',
      args: [],
    );
  }

  /// `Serene`
  String get serene {
    return Intl.message(
      'Serene',
      name: 'serene',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get content {
    return Intl.message(
      'Content',
      name: 'content',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Select Month`
  String get montlyDateSelectTitle {
    return Intl.message(
      'Select Month',
      name: 'montlyDateSelectTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select Year`
  String get yearlyDateSelectTitle {
    return Intl.message(
      'Select Year',
      name: 'yearlyDateSelectTitle',
      desc: '',
      args: [],
    );
  }

  /// `How was your day?`
  String get howWasYourDay {
    return Intl.message(
      'How was your day?',
      name: 'howWasYourDay',
      desc: '',
      args: [],
    );
  }

  /// `Emotion`
  String get emotion {
    return Intl.message(
      'Emotion',
      name: 'emotion',
      desc: '',
      args: [],
    );
  }

  /// `Person`
  String get person {
    return Intl.message(
      'Person',
      name: 'person',
      desc: '',
      args: [],
    );
  }

  /// `Sleep`
  String get sleep {
    return Intl.message(
      'Sleep',
      name: 'sleep',
      desc: '',
      args: [],
    );
  }

  /// `Diary`
  String get diary {
    return Intl.message(
      'Diary',
      name: 'diary',
      desc: '',
      args: [],
    );
  }

  /// `Today's Photo`
  String get todaysPhoto {
    return Intl.message(
      'Today\'s Photo',
      name: 'todaysPhoto',
      desc: '',
      args: [],
    );
  }

  /// `go to top`
  String get scrollToTop {
    return Intl.message(
      'go to top',
      name: 'scrollToTop',
      desc: '',
      args: [],
    );
  }

  /// `Enter your content here`
  String get enterContentPrompt {
    return Intl.message(
      'Enter your content here',
      name: 'enterContentPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Select a photo`
  String get selectPhotoPrompt {
    return Intl.message(
      'Select a photo',
      name: 'selectPhotoPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Sleep Duration : {hours} hours {minutes} minutes`
  String sleepDuration(Object hours, Object minutes) {
    return Intl.message(
      'Sleep Duration : $hours hours $minutes minutes',
      name: 'sleepDuration',
      desc: '',
      args: [hours, minutes],
    );
  }

  /// `bedtime`
  String get bedtime {
    return Intl.message(
      'bedtime',
      name: 'bedtime',
      desc: '',
      args: [],
    );
  }

  /// `wake up time`
  String get wakeUpTime {
    return Intl.message(
      'wake up time',
      name: 'wakeUpTime',
      desc: '',
      args: [],
    );
  }

  /// `Select Month & Day`
  String get selectMonthDay {
    return Intl.message(
      'Select Month & Day',
      name: 'selectMonthDay',
      desc: '',
      args: [],
    );
  }

  /// `Community`
  String get communityTitle {
    return Intl.message(
      'Community',
      name: 'communityTitle',
      desc: '',
      args: [],
    );
  }

  /// `Mood Analysis`
  String get moodAnalysis {
    return Intl.message(
      'Mood Analysis',
      name: 'moodAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `Today's mood analysis.`
  String get moodAnalysisExplanation {
    return Intl.message(
      'Today\'s mood analysis.',
      name: 'moodAnalysisExplanation',
      desc: '',
      args: [],
    );
  }

  /// `happiness`
  String get happiness {
    return Intl.message(
      'happiness',
      name: 'happiness',
      desc: '',
      args: [],
    );
  }

  /// `unhappiness`
  String get unhappiness {
    return Intl.message(
      'unhappiness',
      name: 'unhappiness',
      desc: '',
      args: [],
    );
  }

  /// `activeness`
  String get activeness {
    return Intl.message(
      'activeness',
      name: 'activeness',
      desc: '',
      args: [],
    );
  }

  /// `sleepiness`
  String get sleepiness {
    return Intl.message(
      'sleepiness',
      name: 'sleepiness',
      desc: '',
      args: [],
    );
  }

  /// `Mood Cloud`
  String get moodCloud {
    return Intl.message(
      'Mood Cloud',
      name: 'moodCloud',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
