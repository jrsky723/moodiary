import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/features/add_diary/model/sleep_time.dart';
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

  int totalHour = 0;
  int totalMinute = 0;

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

  String formattedTime(String? period, int? hour, int? minute) =>
      "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period";

  void _showTimePickerDialog(
      bool isBedtime, String title, String? period, int? hour, int? minute) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<String>(
                    value: period,
                    items: ['AM', 'PM'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        period = newValue!;
                      });
                    },
                  ),
                  DropdownButton<int>(
                    value: hour! > 12 ? hour! - 12 : hour,
                    items: List<int>.generate(12, (index) => index + 1)
                        .map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        hour = newValue!;
                      });
                    },
                  ),
                  DropdownButton<int>(
                    value: minute,
                    items: List<int>.generate(60, (index) => index)
                        .map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString().padLeft(2, '0')),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        minute = newValue!;
                      });
                    },
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
            Column(
              children: [
                ElevatedButton(
                  onPressed: () => _showTimePickerDialog(
                      true,
                      S.of(context).bedtime,
                      bedTime.period,
                      bedTime.hour,
                      bedTime.minute),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    backgroundColor: isDarkMode(context)
                        ? Colors.grey.shade500
                        : Colors.grey.shade300,
                    surfaceTintColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  child: Text(
                    formattedTime(
                      bedTime.period,
                      bedTime.hour,
                      bedTime.minute,
                    ),
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                ),
                Text(
                  S.of(context).bedtime,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () => _showTimePickerDialog(
                      false,
                      S.of(context).wakeUpTime,
                      wakeTime.period,
                      wakeTime.hour,
                      wakeTime.minute),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    backgroundColor: isDarkMode(context)
                        ? Colors.grey.shade500
                        : Colors.grey.shade300,
                    surfaceTintColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  child: Text(
                    formattedTime(
                      wakeTime.period,
                      wakeTime.hour,
                      wakeTime.minute,
                    ),
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                ),
                Text(
                  S.of(context).wakeUpTime,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
