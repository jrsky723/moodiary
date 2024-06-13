import 'package:flutter/material.dart';
import 'package:moodiary/constants/sizes.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const CalendarWidget(
      {super.key, required this.initialDate, required this.onDateSelected});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _focusedDate;
  late DateTime _selectedDate;
  late int _selectedYear;

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
        _buildDaysOfWeek(),
        _buildDates(),
      ],
    );
  }

  Widget _buildHeader() {
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
            DropdownButton<int>(
              value: _selectedYear,
              items: List.generate(
                100,
                (index) => DropdownMenuItem(
                  value: 2000 + index,
                  child: Text('${2000 + index}년'),
                ),
              ),
              onChanged: (year) {
                setState(() {
                  _selectedYear = year!;
                  _focusedDate = DateTime(_selectedYear, _focusedDate.month);
                });
              },
            ),
            Text(
              "${_focusedDate.month}월",
              style: const TextStyle(
                  fontSize: Sizes.size16, fontWeight: FontWeight.bold),
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

  Widget _buildDaysOfWeek() {
    const daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: daysOfWeek
          .map((day) => Text(
                day,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ))
          .toList(),
    );
  }

  Widget _buildDates() {
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

  Widget _buildDateTile(int day) {
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
