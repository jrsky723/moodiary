import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodiary/common/widgets/date_selector_tab.dart';
import 'package:moodiary/constants/date.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/dashboard/widgets/show_date_selection_sheet.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const CalendarWidget(
      {super.key, required this.initialDate, required this.onDateSelected});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _focusedDate;
  late DateTime _selectedDate;
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;
  final DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _focusedDate = widget.initialDate;
    _selectedDate = widget.initialDate;
    _selectedYear = widget.initialDate.year;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(),
        _buildWeekdays(),
        _buildDates(),
      ],
    );
  }

  Future<void> _onDateSelectorTap() async {
    final ScrollController scrollController = ScrollController();
    final int selectedIndex =
        (_now.year - _selectedYear) * 12 + _now.month - _selectedMonth;
    final int itemCount = _now.month + (_now.year - Date.minYear) * 12;
    const double itemExtent = 50;
    final double initialScrollOffset = selectedIndex * itemExtent;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(initialScrollOffset);
      }
    });

    DateTime? picked = await showDateSelectionSheet(
      context: context,
      scrollController: scrollController,
      isMonthly: true,
      itemExtent: itemExtent,
      selectedIndex: selectedIndex,
      itemCount: itemCount,
      now: _now,
    );

    if (picked != null) {
      setState(
        () {
          _selectedYear = picked.year;
          _selectedMonth = picked.month;
          _focusedDate = DateTime(_selectedYear, _selectedMonth);
        },
      );
    }
  }

  Row _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _focusedDate =
                  DateTime(_focusedDate.year, _focusedDate.month - 1);
            });
          },
        ),
        Row(
          children: [
            DateSelectorTab(
              text: DateFormat.yMMMM()
                  .format(DateTime(_selectedYear, _selectedMonth)),
              onTap: _onDateSelectorTap,
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            setState(() {
              _focusedDate =
                  DateTime(_focusedDate.year, _focusedDate.month + 1);
            });
          },
        ),
      ],
    );
  }

  Row _buildWeekdays() {
    final DateTime now = DateTime.now();
    final DateTime sunday =
        DateTime.now().subtract(Duration(days: now.weekday));
    return Row(
      children: List.generate(
        DateTime.daysPerWeek,
        (index) {
          return Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(Sizes.size4),
              child: Opacity(
                opacity: 0.8,
                child: Text(
                  DateFormat.E().format(sunday.add(Duration(days: index))),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Column _buildDates() {
    final daysInMonth =
        DateTime(_focusedDate.year, _focusedDate.month + 1, 0).day;
    final firstDayOfWeek =
        DateTime(_focusedDate.year, _focusedDate.month, 1).weekday;
    final weeks = <Widget>[];

    int day = 1 - firstDayOfWeek;
    while (day <= daysInMonth) {
      final week = <Widget>[];
      for (int i = 0; i < 7; i++) {
        if (day > 0 && day <= daysInMonth) {
          week.add(_buildDateTile(day));
        } else {
          week.add(Expanded(child: Container()));
        }
        day++;
      }
      weeks.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: week,
      ));
    }

    return Column(
      children: weeks,
    );
  }

  Expanded _buildDateTile(int day) {
    final date = DateTime(_focusedDate.year, _focusedDate.month, day);
    final isSelected = _selectedDate.year == date.year &&
        _selectedDate.month == date.month &&
        _selectedDate.day == date.day;
    final isToday = DateTime.now().year == date.year &&
        DateTime.now().month == date.month &&
        DateTime.now().day == date.day;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedDate = date;
          });
          widget.onDateSelected(date);
        },
        child: Container(
          margin: const EdgeInsets.all(Sizes.size4),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).primaryColor
                : isToday
                    ? Colors.grey[300]
                    : null,
            borderRadius: BorderRadius.circular(Sizes.size10),
          ),
          child: Center(
            child: Text(
              '$day',
              style: TextStyle(
                color: isSelected ? Colors.white : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
