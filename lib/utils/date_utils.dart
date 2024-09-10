bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

int daysInMonth(int year, int month) {
  // 0 is the day before the first day of the month
  return DateTime(year, month + 1, 0).day;
}

int daysInYear(int year) {
  DateTime firstDay = DateTime(year, 1, 1);
  DateTime lastDay = DateTime(year + 1, 1, 1);
  return lastDay.difference(firstDay).inDays;
}
