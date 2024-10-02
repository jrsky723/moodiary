import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/calendar/models/calendar_entry.dart';
import 'package:moodiary/features/calendar/repos/calendar_repo.dart';

class CalendarViewModel extends AsyncNotifier<List<CalendarEntry>> {
  late final CalendarRepository _repo;
  late List<CalendarEntry> _list;

  @override
  FutureOr<List<CalendarEntry>> build() async {
    _repo = ref.read(calendarRepo);
    _list = await _fetchEntries();
    return _list;
  }

  List<DateTime> _generateDaysForYearMonth(DateTime date) {
    List<DateTime> days = [];
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

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

  Future<List<CalendarEntry>> _fetchEntries({
    DateTime? date, // 달 정보가 있는 date
  }) async {
    final user = ref.read(authRepo).user;
    final uid = user?.uid;
    final month = date ?? DateTime.now(); // date가 없으면 현재 달
    final result = await _repo.fetchDiariesByUserAndMonth(uid!, month);

    List<CalendarEntry> fetchedEntries = result.docs
        .map(
          (doc) => CalendarEntry.fromJson(json: doc.data()),
        )
        .toList();

    final days = _generateDaysForYearMonth(month); // 캘린더 한 화면안에 있는 날짜들 (이전달 포함)

    final entries = days.map((day) {
      final entry = fetchedEntries.firstWhere(
        (entry) =>
            entry.date.year == day.year &&
            entry.date.month == day.month &&
            entry.date.day == day.day,
        orElse: () => CalendarEntry.empty(date: day),
      );
      return entry;
    }).toList();

    return entries;
  }

  Future<void> changeMonth(DateTime date) async {
    state = const AsyncValue.loading();
    final entries = await _fetchEntries(date: date);
    _list = entries;
    state = AsyncValue.data(_list);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final entries = await _fetchEntries();
    _list = entries;
    state = AsyncValue.data(_list);
  }
}

final calendarProvider =
    AsyncNotifierProvider<CalendarViewModel, List<CalendarEntry>>(
  () => CalendarViewModel(),
);
