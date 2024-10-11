import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:moodiary/common/widgets/date_selector_tab.dart';
import 'package:intl/intl.dart';
import 'package:moodiary/constants/date.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/calendar/models/calendar_entry.dart';
import 'package:moodiary/features/calendar/view_models/calendar_view_model.dart';
import 'package:moodiary/features/calendar/views/search_screen.dart';
import 'package:moodiary/features/calendar/views/widgets/calender_entry_widget.dart';
import 'package:moodiary/features/calendar/views/widgets/year_month_select_dialog.dart';
import 'package:moodiary/features/diary/views/add_diary_screen.dart';
import 'package:moodiary/features/diary/views/diary_detail_screen.dart';
import 'package:moodiary/generated/l10n.dart';
import 'package:moodiary/utils/date_utils.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late DateTime _selectedDate;
  late DateTime _now;
  final ScrollController _calendarScrollController = ScrollController();
  bool _monthChanging = false;
  bool _isSnackBarVisible = false;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _selectedDate = _now;
  }

  @override
  void dispose() {
    _calendarScrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    setState(() {
      _now = DateTime.now();
    });
    ref.read(calendarProvider.notifier).refresh(
          _selectedDate,
        );
  }

  void _onSwipeChangeMonth(bool isNext) {
    // 달이 한번에 한번씩 바뀌게 하기 위해서
    if (_monthChanging) return;
    setState(() {
      _monthChanging = true;
      if (isNext) {
        if (_selectedDate.year > _now.year ||
            (_selectedDate.year == _now.year &&
                _selectedDate.month >= _now.month)) {
          return;
        }
        _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1);
      } else {
        if (_selectedDate.year == Date.minYear && _selectedDate.month == 1) {
          return;
        }
        _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1);
      }
    });
    ref.read(calendarProvider.notifier).changeMonth(_selectedDate);
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _monthChanging = false;
      });
    });
  }

  Future<void> _onDateSelectorTap() async {
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
      });
      ref.read(calendarProvider.notifier).changeMonth(_selectedDate);
    }
  }

  void _onEntryTap(CalendarEntry entry) {
    final date = entry.date;
    // 미래의 일기는 접근 안되게 메세지 출력, 출력 중복은 방지
    if (date.isAfter(_now)) {
      if (_isSnackBarVisible) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).cantAccessFutureDiary),
          duration: const Duration(seconds: 2),
        ),
      );
      _isSnackBarVisible = true;

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isSnackBarVisible = false;
        });
      });
      return;
    }

    setState(() {
      _selectedDate = date;
    });
    // 다이어리가 있으면 DiaryDetail Screen
    if (entry.hasDiary) {
      context.pushNamed(
        DiaryDetailScreen.routeName,
        pathParameters: {'diaryId': entry.diaryId!},
        extra: date,
      );
    } else {
      // 다이어리가 없으면 AddDiaryScreen
      context.pushNamed(
        AddDiaryScreen.routeName,
        extra: date,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                pinned: true,
                surfaceTintColor: Colors.transparent,
                title: Text(S.of(context).calendar),
                actions: [
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
                child: DateSelectorTab(
                  text: DateFormat.yMMMM().format(_selectedDate),
                  onTap: _onDateSelectorTap,
                ),
              ),
              SliverToBoxAdapter(
                child: _buildWeekdays(context),
              ),
              SliverToBoxAdapter(
                child: _buildCalendar(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildWeekdays(BuildContext context) {
    final DateTime sunday =
        DateTime.now().subtract(Duration(days: _now.weekday));
    return Row(
      children: List.generate(
        DateTime.daysPerWeek,
        (index) {
          return Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(Sizes.size8),
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

  Widget _buildCalendar() {
    double width = MediaQuery.of(context).size.width;
    double scrollThreshold = 0.25;

    return SizedBox(
      height: 500,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (_monthChanging) return true;
          double scrollPosition = scrollInfo.metrics.pixels; // 현재 스크롤 위치
          double scrollRatio = scrollPosition / width; // 현재 스크롤 위치 비율
          if (scrollRatio > scrollThreshold) {
            _onSwipeChangeMonth(true);
          } else if (scrollRatio < -scrollThreshold) {
            _onSwipeChangeMonth(false);
          }
          return true;
        },
        child: SingleChildScrollView(
          controller: _calendarScrollController,
          physics: _monthChanging
              ? const NeverScrollableScrollPhysics()
              : const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: width + 1, // 스와이프가 가능하도록 1px 추가
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 1000),
              child: ref.watch(calendarProvider).when(
                data: (data) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7, // 한 주의 7일
                      childAspectRatio: 9 / 11,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final entry = data[index];
                      final date = entry.date;
                      if (date.year != _selectedDate.year ||
                          date.month != _selectedDate.month) {
                        return Container();
                      }
                      final isSelected = isSameDay(date, _selectedDate);
                      final isToday = isSameDay(date, _now);
                      return GestureDetector(
                        onTap: () => _onEntryTap(entry),
                        child: CalendarEntryWidget(
                          entry: entry,
                          isSelected: isSelected,
                          isToday: isToday,
                        ),
                      );
                    },
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (error, stackTrace) {
                  return Center(
                    child: Text(
                      error.toString(),
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
