import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/add_diary/model/sleep_time.dart';
import 'package:moodiary/features/add_diary/widgets/custom_drop_down.dart';
import 'package:moodiary/features/add_diary/widgets/time_button.dart';
import 'package:moodiary/generated/l10n.dart';
import 'package:moodiary/utils.dart';

class SleepDialog extends StatefulWidget {
  final BuildContext context;
  const SleepDialog({super.key, required this.context});

  @override
  State<SleepDialog> createState() => _SleepDialogState();
}

class _SleepDialogState extends State<SleepDialog> {
  SleepTime bedTime = SleepTime();
  SleepTime wakeTime = SleepTime();

  final List<String> periods = ['AM', 'PM'];
  final List<String> hours = List.generate(12, (index) => index.toString());
  final List<String> minutes = List.generate(60, (index) => index.toString());

  int totalHour = 0;
  int totalMinute = 0;

  String formattedTime(String? period, int? hour, int? minute) =>
      "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period";

  void _getTotaltime() {
    int? bH = bedTime.hour, wH = wakeTime.hour;
    setState(() {
      if (bedTime.period == "PM") {
        bH = bH! + 12;
      }
      log("bedTime.hour: $bH");
      log("bM: $bedTime.minute");
      if (wakeTime.period == "PM") {
        wH = wH! + 12;
      }
      log("wakeTime.hour: $wH");
      log("wM: $wakeTime.minute");
      totalHour = wH! - bH!;
      totalMinute = wakeTime.minute - bedTime.minute;
      if (totalMinute < 0) {
        totalHour = totalHour - 1;
      }
      totalHour = totalHour < 0 ? totalHour + 24 : totalHour;
      totalMinute = totalMinute < 0 ? totalMinute + 60 : totalMinute;
    });
  }

  void _showTimePickerDialog(
      bool isBedtime, String title, String? period, int? hour, int? minute) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,
              style: TextStyle(
                color:
                    isDarkMode(context) ? Colors.grey.shade500 : Colors.black,
              )),
          contentPadding: EdgeInsets.zero,
          actionsPadding: const EdgeInsets.only(
            left: Sizes.size8,
            right: Sizes.size8,
            bottom: Sizes.size5,
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ResizableDropdownButton(
                    items: periods,
                    selectedValue: period!,
                    onChanged: (value) => setState(() {
                      period = value;
                    }),
                    isDarkMode: isDarkMode(context),
                  ),
                  ResizableDropdownButton(
                    title: S.of(context).hour,
                    items: hours,
                    selectedValue: hour.toString(),
                    onChanged: (value) => setState(() {
                      hour = int.parse(value);
                    }),
                    isDarkMode: isDarkMode(context),
                  ),
                  ResizableDropdownButton(
                    title: S.of(context).minute,
                    items: minutes,
                    selectedValue: minute.toString(),
                    onChanged: (value) => setState(() {
                      minute = int.parse(value);
                    }),
                    isDarkMode: isDarkMode(context),
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(S.of(context).cancelBtn),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Update the state of the parent widget when the dialog closes.
                  if (isBedtime) {
                    bedTime.period = period!;
                    bedTime.hour = hour!;
                    bedTime.minute = minute!;
                  } else {
                    wakeTime.period = period!;
                    wakeTime.hour = hour!;
                    wakeTime.minute = minute!;
                  }
                  _getTotaltime();
                });
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).confirmBtn),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!(totalHour == 0 && totalMinute == 0))
          Text(
            S.of(context).sleepDuration(totalHour, totalMinute),
            style: TextStyle(
              color: isDarkMode(context) ? Colors.white : Colors.black,
            ),
          ),
        Gaps.v4,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TimeButton(
              title: S.of(context).bedtime,
              formattedTime:
                  formattedTime(bedTime.period, bedTime.hour, bedTime.minute),
              onPressed: () => _showTimePickerDialog(
                true,
                S.of(context).bedtime,
                bedTime.period,
                bedTime.hour,
                bedTime.minute,
              ),
              isDarkMode: isDarkMode(context),
            ),
            TimeButton(
              title: S.of(context).wakeUpTime,
              formattedTime: formattedTime(
                  wakeTime.period, wakeTime.hour, wakeTime.minute),
              onPressed: () => _showTimePickerDialog(
                false,
                S.of(context).wakeUpTime,
                wakeTime.period,
                wakeTime.hour,
                wakeTime.minute,
              ),
              isDarkMode: isDarkMode(context),
            ),
          ],
        )
      ],
    );
  }
}
