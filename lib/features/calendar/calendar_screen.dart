import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/calendar/widgets/year_month_select_dialog.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DateTime _now = DateTime.now();
  late DateTime _selectedDate;
  List<DateTime> _days = [];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime(_now.year, _now.month, _now.day);
    _days = _generateDaysForYearMonth(_now.year, _now.month);
  }

  List<DateTime> _generateDaysForYearMonth(int year, int month) {
    List<DateTime> days = [];
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);

    int weekDayOfFirstDay = firstDayOfMonth.weekday % 7;

    // 달력의 시작을 이전 달의 마지막 일부터 시작하도록 합니다.
    DateTime startDayOfCalendar =
        firstDayOfMonth.subtract(Duration(days: weekDayOfFirstDay));

    // 달력의 시작일부터 마지막 날까지 days 리스트에 추가합니다.
    for (DateTime day = startDayOfCalendar;
        day.isBefore(lastDayOfMonth.add(const Duration(days: 1)));
        day = day.add(const Duration(days: 1))) {
      days.add(day);
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Calendar'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(Sizes.size40),
          child: GestureDetector(
            onTap: () async {
              DateTime? picked = await showDialog(
                context: context,
                builder: (context) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: YearMonthSelectDialog(
                      selectedDate: _selectedDate,
                    ),
                  );
                },
              );

              if (picked != null) {
                setState(() {
                  _selectedDate = picked;
                  _days = _generateDaysForYearMonth(picked.year, picked.month);
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(Sizes.size8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${_selectedDate.year}년 ${_selectedDate.month}월'),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, // 7 days a week
        ),
        itemCount: _days.length,
        itemBuilder: (context, index) {
          DateTime day = _days[index];
          if (day.year != _selectedDate.year ||
              day.month != _selectedDate.month) {
            return Container();
          }
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = day;
              });
            },
            child: Container(
              margin: const EdgeInsets.all(4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _selectedDate == day ? Colors.blue[200] : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('${day.day}'),
            ),
          );
        },
      ),
    );
  }
}
