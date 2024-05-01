import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moodiary/features/add_diary/model/sleepTime.dart';

class SleepDialog extends StatefulWidget {
  final BuildContext context;
  const SleepDialog({super.key, required this.context});

  @override
  State<SleepDialog> createState() => _SleepDialogState();
}

class _SleepDialogState extends State<SleepDialog> {
  SleepTime bedTime = SleepTime();
  SleepTime wakeTime = SleepTime();

  int? totalHour;
  int? totalMinute;

  void _getTotaltime() {
    int? bH = bedTime.Hour, wH = wakeTime.Hour;
    setState(() {
      if (bedTime.Period == "PM") {
        bH = bH! + 12;
      }
      log("bedTime.Hour: $bH");
      log("bM: $bedTime.Minute");
      if (wakeTime.Period == "PM") {
        wH = wH! + 12;
      }
      log("wakeTime.Hour: $wH");
      log("wM: $wakeTime.Minute");
      totalHour = wH! - bH!;
      totalMinute = wakeTime.Minute! - bedTime.Minute!;
      if (totalMinute! < 0) {
        totalHour = totalHour! - 1;
      }
      totalHour = totalHour! < 0 ? totalHour! + 24 : totalHour!;
      totalMinute = totalMinute! < 0 ? totalMinute! + 60 : totalMinute!;
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
              return Flex(
                direction: Axis.horizontal,
                children: [
                  Row(
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
                        value: hour,
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
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Update the state of the parent widget when the dialog closes.
                  if (isBedtime) {
                    bedTime.Period = period;
                    bedTime.Hour = hour;
                    bedTime.Minute = minute;
                  } else {
                    wakeTime.Period = period;
                    wakeTime.Hour = hour;
                    wakeTime.Minute = minute;
                  }
                  _getTotaltime();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Set Time'),
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
        if (totalHour != 0 &&
            totalMinute != 0 &&
            totalHour != null &&
            totalMinute != null)
          Text("수면 시간: $totalHour시간 $totalMinute분"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                ElevatedButton(
                  onPressed: () => _showTimePickerDialog(true, "취침 시각",
                      bedTime.Period, bedTime.Hour, bedTime.Minute),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.grey.shade300,
                    surfaceTintColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  child: Text(
                    formattedTime(
                      bedTime.Period,
                      bedTime.Hour,
                      bedTime.Minute,
                    ),
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                ),
                Text(
                  "취침",
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
                  onPressed: () => _showTimePickerDialog(false, "기상 시각",
                      wakeTime.Period, wakeTime.Hour, wakeTime.Minute),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.grey.shade300,
                    surfaceTintColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  child: Text(
                    formattedTime(
                      wakeTime.Period,
                      wakeTime.Hour,
                      wakeTime.Minute,
                    ),
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                ),
                Text(
                  "기상",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade800,
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
