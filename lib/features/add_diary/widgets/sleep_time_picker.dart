import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class SleepDialog extends StatefulWidget {
  final BuildContext context;
  const SleepDialog({
    super.key,
    required this.context,
  });

  @override
  _SleepDialogState createState() => _SleepDialogState();
}

class _SleepDialogState extends State<SleepDialog> {
  DateTime? bedtime;
  DateTime? wakeTime;

  void _openTimePicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("시간 선택"),
          content: SizedBox(
            height: 200, // 다이얼로그 크기 조절
            child: Column(
              children: [
                ElevatedButton(
                  child: const Text("취침 시각 선택"),
                  onPressed: () => _pickTime(isBedTime: true),
                ),
                ElevatedButton(
                  child: const Text("기상 시각 선택"),
                  onPressed: () => _pickTime(isBedTime: false),
                ),
                if (bedtime != null)
                  Text("취침 시각: ${bedtime!.hour}시${bedtime!.minute}분"),
                if (wakeTime != null)
                  Text("기상 시각: ${wakeTime!.hour}시${wakeTime!.minute}분"),
              ],
            ),
          ),
        );
      },
      barrierColor: Colors.black54, // 배경 어둡게 처리
    );
  }

  void _pickTime({required bool isBedTime}) {
    DatePicker.showTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (date) {
        setState(() {
          if (isBedTime) {
            bedtime = date;
          } else {
            wakeTime = date;
          }
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        backgroundColor: Colors.grey.shade300,
        foregroundColor: Colors.grey.shade500,
        surfaceTintColor: Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: _openTimePicker,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "수면을 기록해주세요",
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
