import 'package:flutter/material.dart';
import 'package:moodiary/common/widgets/dialog_button.dart';
import 'package:moodiary/constants/date.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/calendar/views/widgets/scroll_dialog.dart';
import 'package:moodiary/generated/l10n.dart';

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
  late int _selectedYear = widget.selectedDate.year;
  late int _selectedMonth = widget.selectedDate.month;
  final DateTime _now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    bool isKorean = Localizations.localeOf(context).languageCode == 'ko';
    ScrollDialog monthScrollDialog = ScrollDialog(
      initialItemIndex: widget.selectedDate.month - 1,
      startNumber: 1,
      endNumber: 12,
      mode: ScrollDialogMode.month,
      onSelectedItemChanged: (month) => _selectedMonth = month,
    );
    ScrollDialog yearScrollDialog = ScrollDialog(
      initialItemIndex: widget.selectedDate.year - Date.minYear,
      startNumber: Date.minYear,
      endNumber: _now.year + 1,
      mode: ScrollDialogMode.year,
      onSelectedItemChanged: (year) => _selectedYear = year,
    );
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
      title: Center(
        child: Text(
          S.of(context).selectMonthYear,
          style: const TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      content: Row(
        children: [
          // 한국어일 경우 연도를 먼저 선택하도록 함
          if (isKorean) yearScrollDialog,
          monthScrollDialog,
          if (!isKorean) yearScrollDialog,
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: DialogButton(
                btnColor: Colors.grey.shade300,
                text: S.of(context).cancelBtn,
                textColor: Colors.grey.shade700,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              child: DialogButton(
                btnColor: Theme.of(context).primaryColor,
                text: S.of(context).confirmBtn,
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
