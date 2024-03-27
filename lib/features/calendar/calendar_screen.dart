import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/constants/date.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/calendar/search_screen.dart';
import 'package:moodiary/features/calendar/widgets/year_month_select_dialog.dart';
import 'package:moodiary/utils.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DateTime _now = DateTime.now();
  late DateTime _selectedDate;
  List<DateTime> _days = [];
  bool _monthChanging = false;

  final ScrollController _calendarScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime(_now.year, _now.month, _now.day);
    _days = _generateDaysForYearMonth(_now.year, _now.month);
  }

  @override
  void dispose() {
    _calendarScrollController.dispose();
    super.dispose();
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

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _days =
          _generateDaysForYearMonth(_selectedDate.year, _selectedDate.month);
    });
  }

  void _changeMonth(bool isNext) {
    if (_monthChanging) return;
    _monthChanging = true;
    setState(() {
      if (isNext) {
        if (_selectedDate.year > _now.year ||
            (_selectedDate.year == _now.year &&
                _selectedDate.month >= _now.month)) {
          return;
        }
        _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1);
      } else {
        if (_selectedDate.year == 2000 && _selectedDate.month == 1) {
          return;
        }
        _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1);
      }
      _days =
          _generateDaysForYearMonth(_selectedDate.year, _selectedDate.month);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: _onRefresh,
            ),
            SliverAppBar(
              centerTitle: true,
              pinned: true,
              surfaceTintColor: Colors.transparent,
              title: const Text('Calendar'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.today),
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(_now.year, _now.month, _now.day);
                      _days = _generateDaysForYearMonth(_now.year, _now.month);
                    });
                  },
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
                  onPressed: () {
                    // open search screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: _buildYearMonthSelector(context),
            ),
            SliverToBoxAdapter(
              child: _buildWeekdays(context),
            ),
            SliverToBoxAdapter(
              child: _buildCalendar(),
            ),
            const SliverToBoxAdapter(
              child: Gaps.v32,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildYearMonthSelector(BuildContext context) {
    return GestureDetector(
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
    );
  }

  Row _buildWeekdays(BuildContext context) {
    return Row(
      children: List.generate(
        7,
        (index) {
          return Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(Sizes.size8),
              child: Opacity(
                opacity: 0.8,
                child: Text(
                  WEEKDAYS[index],
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

  Widget _buildCalendar() {
    double width = MediaQuery.of(context).size.width;
    double scrollThreshold = 0.25;

    return SizedBox(
      height: 500,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo is ScrollEndNotification) {
            if (_monthChanging) {
              _monthChanging = false;
            }
          }
          if (_monthChanging) return true;
          double scrollPosition = scrollInfo.metrics.pixels; // 현재 스크롤 위치
          double scrollRatio = scrollPosition / width; // 현재 스크롤 위치 비율
          if (scrollRatio > scrollThreshold) {
            _changeMonth(true);
          } else if (scrollRatio < -scrollThreshold) {
            _changeMonth(false);
          }
          return true;
        },
        child: SingleChildScrollView(
          controller: _calendarScrollController,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: width + 1,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, // 한 주의 7일
                childAspectRatio: 9 / 11,
              ),
              itemCount: _days.length,
              itemBuilder: (context, index) {
                DateTime day = _days[index];
                if (day.year != _selectedDate.year ||
                    day.month != _selectedDate.month) {
                  return Container();
                }
                final isSelected = isSameDay(day, _selectedDate);
                final isToday = isSameDay(day, _now);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = day;
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.transparent,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundImage:
                              Image.asset('assets/images/expressionless.png')
                                  .image,
                        ),
                      ),
                      Gaps.v4,
                      Container(
                        width: Sizes.size32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isToday
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(Sizes.size8),
                        ),
                        child: Text(
                          day.day.toString(),
                          style: TextStyle(
                            fontSize: Sizes.size11,
                            fontWeight: FontWeight.w600,
                            color: isToday
                                ? Colors.white
                                : isSelected
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
