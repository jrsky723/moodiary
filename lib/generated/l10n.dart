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

  /// `Today's mood analysis`
  String get moodAnalysisExplanation {
    return Intl.message(
      'Today\'s mood analysis',
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

  /// `Neutral`
  String get neutral {
    return Intl.message(
      'Neutral',
      name: 'neutral',
      desc: '',
      args: [],
    );
  }

  /// `Circumplex Model`
  String get circumplexModel {
    return Intl.message(
      'Circumplex Model',
      name: 'circumplexModel',
      desc: '',
      args: [],
    );
  }

  /// `Positive`
  String get positive {
    return Intl.message(
      'Positive',
      name: 'positive',
      desc: '',
      args: [],
    );
  }

  /// `Negative`
  String get negative {
    return Intl.message(
      'Negative',
      name: 'negative',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Passive`
  String get passive {
    return Intl.message(
      'Passive',
      name: 'passive',
      desc: '',
      args: [],
    );
  }

  /// `Only {days} of Mood data are displayed`
  String dashboardDescription(Object days) {
    return Intl.message(
      'Only $days of Mood data are displayed',
      name: 'dashboardDescription',
      desc: '',
      args: [days],
    );
  }

  /// `Mood Distribution`
  String get moodDistribution {
    return Intl.message(
      'Mood Distribution',
      name: 'moodDistribution',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `{value}D`
  String days(Object value) {
    return Intl.message(
      '${value}D',
      name: 'days',
      desc: '',
      args: [value],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message(
      'User Name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `User name must be at least 2 characters`
  String get userNameMinError {
    return Intl.message(
      'User name must be at least 2 characters',
      name: 'userNameMinError',
      desc: '',
      args: [],
    );
  }

  /// `Nickname`
  String get nickname {
    return Intl.message(
      'Nickname',
      name: 'nickname',
      desc: '',
      args: [],
    );
  }

  /// `Take a photo`
  String get takePhoto {
    return Intl.message(
      'Take a photo',
      name: 'takePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Select from gallery`
  String get selectFromGallery {
    return Intl.message(
      'Select from gallery',
      name: 'selectFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Reset to default profile`
  String get resetToDefaultProfile {
    return Intl.message(
      'Reset to default profile',
      name: 'resetToDefaultProfile',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get pleaseEnterName {
    return Intl.message(
      'Please enter your name',
      name: 'pleaseEnterName',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get bio {
    return Intl.message(
      'Bio',
      name: 'bio',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Select a Date`
  String get selectDate {
    return Intl.message(
      'Select a Date',
      name: 'selectDate',
      desc: '',
      args: [],
    );
  }

  /// `Selected Date: {date}`
  String selectedDate(Object date) {
    return Intl.message(
      'Selected Date: $date',
      name: 'selectedDate',
      desc: '',
      args: [date],
    );
  }

  /// `h`
  String get hour {
    return Intl.message(
      'h',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `m`
  String get minute {
    return Intl.message(
      'm',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `Community`
  String get communityBtn {
    return Intl.message(
      'Community',
      name: 'communityBtn',
      desc: '',
      args: [],
    );
  }

  /// `Post to community`
  String get communityBtnSubtitle {
    return Intl.message(
      'Post to community',
      name: 'communityBtnSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `next`
  String get nextBtn {
    return Intl.message(
      'next',
      name: 'nextBtn',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one number`
  String get pwdnumbererror {
    return Intl.message(
      'Password must contain at least one number',
      name: 'pwdnumbererror',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one special character`
  String get pwdspecialcharerror {
    return Intl.message(
      'Password must contain at least one special character',
      name: 'pwdspecialcharerror',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one uppercase letter`
  String get pwduppercaseerror {
    return Intl.message(
      'Password must contain at least one uppercase letter',
      name: 'pwduppercaseerror',
      desc: '',
      args: [],
    );
  }

  /// `8 to 20 characters`
  String get pwdlengtherror {
    return Intl.message(
      '8 to 20 characters',
      name: 'pwdlengtherror',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get completeBtn {
    return Intl.message(
      'Complete',
      name: 'completeBtn',
      desc: '',
      args: [],
    );
  }

  /// `login`
  String get login {
    return Intl.message(
      'login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Can't access future diary`
  String get cantAccessFutureDiary {
    return Intl.message(
      'Can\'t access future diary',
      name: 'cantAccessFutureDiary',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account?`
  String get deleteAccountMessage {
    return Intl.message(
      'Are you sure you want to delete your account?',
      name: 'deleteAccountMessage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Create Profile`
  String get createProfile {
    return Intl.message(
      'Create Profile',
      name: 'createProfile',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `What is your email and password, {username}?`
  String usernameTitle(Object username) {
    return Intl.message(
      'What is your email and password, $username?',
      name: 'usernameTitle',
      desc: '',
      args: [username],
    );
  }

  /// `Emotion Analysis Diary App`
  String get appDiscription {
    return Intl.message(
      'Emotion Analysis Diary App',
      name: 'appDiscription',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account yet?  `
  String get doYouHaveAccount {
    return Intl.message(
      'Don\'t have an account yet?  ',
      name: 'doYouHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `goto Sign Up`
  String get gotoSignUp {
    return Intl.message(
      'goto Sign Up',
      name: 'gotoSignUp',
      desc: '',
      args: [],
    );
  }

  /// `You can always change this later`
  String get nickBioDiscription {
    return Intl.message(
      'You can always change this later',
      name: 'nickBioDiscription',
      desc: '',
      args: [],
    );
  }

  /// `Nickname have to be at least 3 characters`
  String get nicknameValidError {
    return Intl.message(
      'Nickname have to be at least 3 characters',
      name: 'nicknameValidError',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?  `
  String get doYouHaveAnAccountAlready {
    return Intl.message(
      'Already have an account?  ',
      name: 'doYouHaveAnAccountAlready',
      desc: '',
      args: [],
    );
  }

  /// `goto Login`
  String get gotoLogin {
    return Intl.message(
      'goto Login',
      name: 'gotoLogin',
      desc: '',
      args: [],
    );
  }

  /// `You do not change this later`
  String get usernameDiscription {
    return Intl.message(
      'You do not change this later',
      name: 'usernameDiscription',
      desc: '',
      args: [],
    );
  }

  /// `see More`
  String get seeMore {
    return Intl.message(
      'see More',
      name: 'seeMore',
      desc: '',
      args: [],
    );
  }

  /// `No Data`
  String get noData {
    return Intl.message(
      'No Data',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `This is a Future Diary`
  String get thisIsFutureDiary {
    return Intl.message(
      'This is a Future Diary',
      name: 'thisIsFutureDiary',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while fetching data`
  String get fetchDataError {
    return Intl.message(
      'An error occurred while fetching data',
      name: 'fetchDataError',
      desc: '',
      args: [],
    );
  }

  /// `Please write a diary or add a photo at least`
  String get pleaseWriteDiaryOrAddPhoto {
    return Intl.message(
      'Please write a diary or add a photo at least',
      name: 'pleaseWriteDiaryOrAddPhoto',
      desc: '',
      args: [],
    );
  }

  /// `text save`
  String get textSave {
    return Intl.message(
      'text save',
      name: 'textSave',
      desc: '',
      args: [],
    );
  }

  /// `At least one image must be kept`
  String get OneImageMustBeKept {
    return Intl.message(
      'At least one image must be kept',
      name: 'OneImageMustBeKept',
      desc: '',
      args: [],
    );
  }

  /// `Edit Diary`
  String get editDiary {
    return Intl.message(
      'Edit Diary',
      name: 'editDiary',
      desc: '',
      args: [],
    );
  }

  /// `Diary Content`
  String get diaryContent {
    return Intl.message(
      'Diary Content',
      name: 'diaryContent',
      desc: '',
      args: [],
    );
  }

  /// `Images`
  String get images {
    return Intl.message(
      'Images',
      name: 'images',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Enter your diary content`
  String get enterYourDiaryContent {
    return Intl.message(
      'Enter your diary content',
      name: 'enterYourDiaryContent',
      desc: '',
      args: [],
    );
  }

  /// `Please enter some content`
  String get pleaseEnterSomeContent {
    return Intl.message(
      'Please enter some content',
      name: 'pleaseEnterSomeContent',
      desc: '',
      args: [],
    );
  }

  /// `No images available`
  String get noImagesAvailable {
    return Intl.message(
      'No images available',
      name: 'noImagesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your diary?`
  String get deleteDiaryMessage {
    return Intl.message(
      'Are you sure you want to delete your diary?',
      name: 'deleteDiaryMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete Diary`
  String get deleteDiary {
    return Intl.message(
      'Delete Diary',
      name: 'deleteDiary',
      desc: '',
      args: [],
    );
  }

  /// `Diary has been successfully deleted`
  String get deleteDiarySuccessMessage {
    return Intl.message(
      'Diary has been successfully deleted',
      name: 'deleteDiarySuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while deleting the diary`
  String get deleteDiaryErrorMessage {
    return Intl.message(
      'An error occurred while deleting the diary',
      name: 'deleteDiaryErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Email is not valid`
  String get emailNotValid {
    return Intl.message(
      'Email is not valid',
      name: 'emailNotValid',
      desc: '',
      args: [],
    );
  }

  /// `Email and Password are not valid`
  String get emailAndPasswordAreNotValid {
    return Intl.message(
      'Email and Password are not valid',
      name: 'emailAndPasswordAreNotValid',
      desc: '',
      args: [],
    );
  }

  /// `Create Username`
  String get createUsername {
    return Intl.message(
      'Create Username',
      name: 'createUsername',
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
