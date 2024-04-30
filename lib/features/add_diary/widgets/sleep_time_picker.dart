import 'package:flutter/material.dart';

class SleepDialog extends StatefulWidget {
  final BuildContext context;
  const SleepDialog({super.key, required this.context});

  @override
  State<SleepDialog> createState() => _SleepDialogState();
}

class _SleepDialogState extends State<SleepDialog> {
  String? bPeriod = DateTime.now().hour >= 12 ? "PM" : "AM"; // AM or PM
  int? bHour = DateTime.now().hour; // Hour of the day
  int? bMinute = DateTime.now().minute; // Minute

  String? wPeriod = DateTime.now().hour >= 12 ? "PM" : "AM"; // AM or PM
  int? wHour = DateTime.now().hour; // Hour of the day
  int? wMinute = DateTime.now().minute; // Minute

  int? totalHour;
  int? totalMinute;

  void _getTotalHour(int? H1, int? H2) {
    setState(() {
      totalHour = H1! - H2!;
    });
  }

  void _getTotalMinute(int? M1, int? M2) {
    setState(() {
      totalMinute = M1! - M2!;
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
              return SizedBox(
                child: Row(
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
                  _getTotalHour(bHour, wHour);
                  _getTotalMinute(bMinute, wMinute);
                  if (isBedtime) {
                    bPeriod = period;
                    bHour = hour;
                    bMinute = minute;
                  } else {
                    wPeriod = period;
                    wHour = hour;
                    wMinute = minute;
                  }
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
        if (totalHour != null && totalMinute != null)
          Text("취침 시간: $totalHour시간 $totalMinute분"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                ElevatedButton(
                  onPressed: () => _showTimePickerDialog(
                      true, "취침 시각", bPeriod, bHour, bMinute),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.grey.shade300,
                    surfaceTintColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  child: Text(
                    formattedTime(
                      bPeriod,
                      bHour,
                      bMinute,
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
                  onPressed: () => _showTimePickerDialog(
                      false, "기상 시각", wPeriod, wHour, wMinute),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.grey.shade300,
                    surfaceTintColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  child: Text(
                    formattedTime(
                      wPeriod,
                      wHour,
                      wMinute,
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
