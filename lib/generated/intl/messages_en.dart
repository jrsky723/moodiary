// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(days) => "Only ${days} of Mood data are displayed.";

  static String m1(value) => "${value}D";

  static String m2(label) => "Most frequently recorded emotion: ${label}";

  static String m3(date) => "Selected Date: ${date}";

  static String m4(hours, minutes) =>
      "Sleep Duration : ${hours} hours ${minutes} minutes";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "active": MessageLookupByLibrary.simpleMessage("Active"),
        "activeness": MessageLookupByLibrary.simpleMessage("activeness"),
        "alarmed": MessageLookupByLibrary.simpleMessage("Alarmed"),
        "alert": MessageLookupByLibrary.simpleMessage("Alert"),
        "bedtime": MessageLookupByLibrary.simpleMessage("bedtime"),
        "bio": MessageLookupByLibrary.simpleMessage("Bio"),
        "bored": MessageLookupByLibrary.simpleMessage("Bored"),
        "calendar": MessageLookupByLibrary.simpleMessage("Calendar"),
        "cancelBtn": MessageLookupByLibrary.simpleMessage("Cancel"),
        "circumplexModel":
            MessageLookupByLibrary.simpleMessage("Circumplex Model"),
        "communityBtn": MessageLookupByLibrary.simpleMessage("Community"),
        "communityBtnSubtitle":
            MessageLookupByLibrary.simpleMessage("Post to community"),
        "communityTitle": MessageLookupByLibrary.simpleMessage("Community"),
        "completeBtn": MessageLookupByLibrary.simpleMessage("Complete"),
        "confirmBtn": MessageLookupByLibrary.simpleMessage("Confirm"),
        "content": MessageLookupByLibrary.simpleMessage("Content"),
        "darkModeSubtitle":
            MessageLookupByLibrary.simpleMessage("Change to dark mode"),
        "darkModeTitle": MessageLookupByLibrary.simpleMessage("Dark mode"),
        "dashboard": MessageLookupByLibrary.simpleMessage("Dashboard"),
        "dashboardDescription": m0,
        "days": m1,
        "delighted": MessageLookupByLibrary.simpleMessage("Delighted"),
        "diary": MessageLookupByLibrary.simpleMessage("Diary"),
        "diarySearchHint": MessageLookupByLibrary.simpleMessage("Diary Search"),
        "distressed": MessageLookupByLibrary.simpleMessage("Distressed"),
        "editProfile": MessageLookupByLibrary.simpleMessage("Edit Profile"),
        "emotion": MessageLookupByLibrary.simpleMessage("Emotion"),
        "englishModeSubtitle": MessageLookupByLibrary.simpleMessage(
            "Change the language to English"),
        "englishModeTitle":
            MessageLookupByLibrary.simpleMessage("English Mode"),
        "enterContentPrompt":
            MessageLookupByLibrary.simpleMessage("Enter your content here"),
        "excited": MessageLookupByLibrary.simpleMessage("Excited"),
        "glad": MessageLookupByLibrary.simpleMessage("Glad"),
        "gloomy": MessageLookupByLibrary.simpleMessage("Gloomy"),
        "happiness": MessageLookupByLibrary.simpleMessage("happiness"),
        "hour": MessageLookupByLibrary.simpleMessage("h"),
        "howWasYourDay":
            MessageLookupByLibrary.simpleMessage("How was your day?"),
        "login": MessageLookupByLibrary.simpleMessage("login"),
        "minute": MessageLookupByLibrary.simpleMessage("m"),
        "miserable": MessageLookupByLibrary.simpleMessage("Miserable"),
        "monthlyMoodDistTitle":
            MessageLookupByLibrary.simpleMessage("Monthly Mood Distribution"),
        "monthlyMoodFlowTitle":
            MessageLookupByLibrary.simpleMessage("Monthly Mood Flow"),
        "monthlyTab": MessageLookupByLibrary.simpleMessage("Monthly"),
        "montlyDateSelectTitle":
            MessageLookupByLibrary.simpleMessage("Select Month"),
        "moodAnalysis": MessageLookupByLibrary.simpleMessage("Mood Analysis"),
        "moodAnalysisExplanation":
            MessageLookupByLibrary.simpleMessage("Today\'s mood analysis."),
        "moodCloud": MessageLookupByLibrary.simpleMessage("Mood Cloud"),
        "moodDistribution":
            MessageLookupByLibrary.simpleMessage("Mood Distribution"),
        "mostFrequentMoodText": m2,
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "negative": MessageLookupByLibrary.simpleMessage("Negative"),
        "neutral": MessageLookupByLibrary.simpleMessage("Neutral"),
        "nextBtn": MessageLookupByLibrary.simpleMessage("next"),
        "passive": MessageLookupByLibrary.simpleMessage("Passive"),
        "person": MessageLookupByLibrary.simpleMessage("Person"),
        "pleaseEnterName":
            MessageLookupByLibrary.simpleMessage("Please enter your name."),
        "positive": MessageLookupByLibrary.simpleMessage("Positive"),
        "pwdlengtherror":
            MessageLookupByLibrary.simpleMessage("8 to 20 characters"),
        "pwdnumbererror": MessageLookupByLibrary.simpleMessage(
            "Password must contain at least one number"),
        "pwdspecialcharerror": MessageLookupByLibrary.simpleMessage(
            "Password must contain at least one special character"),
        "pwduppercaseerror": MessageLookupByLibrary.simpleMessage(
            "Password must contain at least one uppercase letter"),
        "relaxed": MessageLookupByLibrary.simpleMessage("Relaxed"),
        "resetToDefaultProfile":
            MessageLookupByLibrary.simpleMessage("Reset to default profile"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "scrollToTop": MessageLookupByLibrary.simpleMessage("go to top"),
        "selectDate": MessageLookupByLibrary.simpleMessage("Select a Date"),
        "selectFromGallery":
            MessageLookupByLibrary.simpleMessage("Select from gallery"),
        "selectMonthDay":
            MessageLookupByLibrary.simpleMessage("Select Month & Day"),
        "selectMonthYear":
            MessageLookupByLibrary.simpleMessage("Select Month & Year"),
        "selectPhotoPrompt":
            MessageLookupByLibrary.simpleMessage("Select a photo"),
        "selectedDate": m3,
        "serene": MessageLookupByLibrary.simpleMessage("Serene"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "sleep": MessageLookupByLibrary.simpleMessage("Sleep"),
        "sleepDuration": m4,
        "sleepiness": MessageLookupByLibrary.simpleMessage("sleepiness"),
        "sleepy": MessageLookupByLibrary.simpleMessage("Sleepy"),
        "takePhoto": MessageLookupByLibrary.simpleMessage("Take a photo"),
        "tense": MessageLookupByLibrary.simpleMessage("Tense"),
        "tired": MessageLookupByLibrary.simpleMessage("Tired"),
        "todaysPhoto": MessageLookupByLibrary.simpleMessage("Today\'s Photo"),
        "unhappiness": MessageLookupByLibrary.simpleMessage("unhappiness"),
        "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
        "upset": MessageLookupByLibrary.simpleMessage("Upset"),
        "userName": MessageLookupByLibrary.simpleMessage("User Name"),
        "userNameMinError": MessageLookupByLibrary.simpleMessage(
            "User name must be at least 2 characters."),
        "wakeUpTime": MessageLookupByLibrary.simpleMessage("wake up time"),
        "yearlyDateSelectTitle":
            MessageLookupByLibrary.simpleMessage("Select Year"),
        "yearlyMoodDistTitle":
            MessageLookupByLibrary.simpleMessage("Yearly Mood Distribution"),
        "yearlyMoodFlowTitle":
            MessageLookupByLibrary.simpleMessage("Yearly Mood Flow"),
        "yearlyTab": MessageLookupByLibrary.simpleMessage("Yearly")
      };
}
