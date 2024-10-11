import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/calendar/models/calendar_entry.dart';
import 'package:moodiary/features/diary/repos/diary_repo.dart';
import 'package:moodiary/utils/date_utils.dart';

class CalendarViewModel extends AsyncNotifier<List<CalendarEntry>> {
  late final DiaryRepository _repo;
  late List<CalendarEntry> _list;

  @override
  FutureOr<List<CalendarEntry>> build() async {
    _repo = ref.read(diaryRepo);
    _list = await _fetchEntries();
    return _list;
  }

  List<DateTime> _generateDatesForYearMonth(DateTime date) {
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
    print('uid: $uid');
    final month = date ?? DateTime.now(); // date가 없으면 현재 달
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 0);
    final result = await _repo.fetchDiariesByUserAndDateRange(
      uid: uid!,
      start: start,
      end: end,
    );

    List<CalendarEntry> fetchedEntries = result.docs
        .map(
          (doc) => CalendarEntry.fromJson(json: doc.data()),
        )
        .toList();

    final dates =
        _generateDatesForYearMonth(month); // 캘린더 한 화면안에 있는 날짜들 (이전달 포함)

    final entries = dates.map((date) {
      final entry = fetchedEntries.firstWhere(
        (entry) => isSameDay(entry.date, date),
        orElse: () => CalendarEntry.empty(date: date),
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

  Future<void> refresh(DateTime date) async {
    state = const AsyncValue.loading();
    final entries = await _fetchEntries(date: date);
    _list = entries;
    state = AsyncValue.data(_list);
  }
}

final calendarProvider =
    AsyncNotifierProvider<CalendarViewModel, List<CalendarEntry>>(
  () => CalendarViewModel(),
);
