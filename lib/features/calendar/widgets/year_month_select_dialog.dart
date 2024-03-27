import 'package:flutter/material.dart';
import 'package:moodiary/common/widgets/dialog_button.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/calendar/widgets/scroll_dialog.dart';

class YearMonthSelectDialog extends StatefulWidget {
  final DateTime selectedDate;

  const YearMonthSelectDialog({
    super.key,
    required this.selectedDate,
  });

  @override
  State<YearMonthSelectDialog> createState() => _YearMonthSelectDialogState();
}

class _YearMonthSelectDialogState extends State<YearMonthSelectDialog> {
  final int _startYear = 2000;
  late int _selectedYear = widget.selectedDate.year;
  late int _selectedMonth = widget.selectedDate.month;
  final DateTime _now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.symmetric(
        vertical: Sizes.size12,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Sizes.size40,
        vertical: Sizes.size8,
      ),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: Sizes.size8,
        vertical: Sizes.size12,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.size16),
      ),
      title: const Center(
        child: Text(
          '언제로 이동할까요?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      content: Row(
        children: [
          ScrollDialog(
            initialItemIndex: widget.selectedDate.year - _startYear,
            startNumber: _startYear,
            endNumber: _now.year + 1,
            itemText: '년',
            onSelectedItemChanged: (year) => _selectedYear = year,
          ),
          ScrollDialog(
            initialItemIndex: widget.selectedDate.month - 1,
            startNumber: 1,
            endNumber: 12,
            itemText: '월',
            onSelectedItemChanged: (month) => _selectedMonth = month,
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: DialogButton(
                btnColor: Colors.grey.shade300,
                text: '취소',
                textColor: Colors.grey.shade700,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              child: DialogButton(
                btnColor: Theme.of(context).primaryColor,
                text: '확인',
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pop(
                    context,
                    DateTime(_selectedYear, _selectedMonth, 1),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
