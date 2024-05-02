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

  static String m0(label) => "Most frequently recorded emotion: ${label}";

  static String m1(hours, minutes) =>
      "Sleep Duration : ${hours} hours ${minutes} minutes";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "bedtime": MessageLookupByLibrary.simpleMessage("bedtime"),
        "calendar": MessageLookupByLibrary.simpleMessage("Calendar"),
        "cancelBtn": MessageLookupByLibrary.simpleMessage("Cancel"),
        "confirmBtn": MessageLookupByLibrary.simpleMessage("Confirm"),
        "darkModeSubtitle":
            MessageLookupByLibrary.simpleMessage("Change to dark mode"),
        "darkModeTitle": MessageLookupByLibrary.simpleMessage("Dark mode"),
        "diary": MessageLookupByLibrary.simpleMessage("Diary"),
        "diarySearchHint": MessageLookupByLibrary.simpleMessage("Diary Search"),
        "emotion": MessageLookupByLibrary.simpleMessage("Emotion"),
        "englishModeSubtitle": MessageLookupByLibrary.simpleMessage(
            "Change the language to English"),
        "englishModeTitle":
            MessageLookupByLibrary.simpleMessage("English Mode"),
        "enterContentPrompt":
            MessageLookupByLibrary.simpleMessage("Enter your content here"),
        "happy": MessageLookupByLibrary.simpleMessage("Happy"),
        "howWasYourDay":
            MessageLookupByLibrary.simpleMessage("How was your day?"),
        "monthlyMoodDistTitle":
            MessageLookupByLibrary.simpleMessage("Monthly Mood Distribution"),
        "monthlyMoodFlowTitle":
            MessageLookupByLibrary.simpleMessage("Monthly Mood Flow"),
        "monthlyTab": MessageLookupByLibrary.simpleMessage("Monthly"),
        "montlyDateSelectTitle":
            MessageLookupByLibrary.simpleMessage("Select Month"),
        "mostFrequentMoodText": m0,
        "normal": MessageLookupByLibrary.simpleMessage("Normal"),
        "person": MessageLookupByLibrary.simpleMessage("Person"),
        "sad": MessageLookupByLibrary.simpleMessage("Sad"),
        "scrollToTop": MessageLookupByLibrary.simpleMessage("go to top"),
        "selectMonthDay":
            MessageLookupByLibrary.simpleMessage("Select Month & Day"),
        "selectMonthYear":
            MessageLookupByLibrary.simpleMessage("Select Month & Year"),
        "selectPhotoPrompt":
            MessageLookupByLibrary.simpleMessage("Select a photo"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "sleep": MessageLookupByLibrary.simpleMessage("Sleep"),
        "sleepDuration": m1,
        "todaysPhoto": MessageLookupByLibrary.simpleMessage("Today\'s Photo"),
        "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
        "veryHappy": MessageLookupByLibrary.simpleMessage("Very Happy"),
        "verySad": MessageLookupByLibrary.simpleMessage("Very Sad"),
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
