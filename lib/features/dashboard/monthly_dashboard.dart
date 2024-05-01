import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodiary/common/widgets/date_selector_tab.dart';
import 'package:moodiary/constants/date.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/dashboard/models/mood_entry.dart';
import 'package:moodiary/features/dashboard/widgets/mood_chart_card.dart';
import 'package:moodiary/features/dashboard/widgets/mood_dist_chart.dart';
import 'package:moodiary/features/dashboard/widgets/mood_flow_chart.dart';
import 'package:moodiary/features/dashboard/widgets/show_date_selection_sheet.dart';
import 'package:moodiary/generated/l10n.dart';
import 'package:moodiary/utils.dart';

class MonthlyDashboard extends StatefulWidget {
  const MonthlyDashboard({super.key});

  @override
  State<MonthlyDashboard> createState() => _MonthlyDashboardState();
}

class _MonthlyDashboardState extends State<MonthlyDashboard> {
  final DateTime _now = DateTime.now();
  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;
  late List<MoodEntry> _moodEntries = [];

  @override
  initState() {
    super.initState();
    _moodEntries = generateMoodEntries(
      DateTime(_selectedYear, _selectedMonth),
      daysInMonth(_selectedYear, _selectedMonth),
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
          _moodEntries = generateMoodEntries(
            DateTime(_selectedYear, _selectedMonth),
            daysInMonth(_selectedYear, _selectedMonth),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
        ),
        child: Column(
          children: [
            DateSelectorTab(
              text: DateFormat.yMMMM()
                  .format(DateTime(_selectedYear, _selectedMonth)),
              onTap: _onDateSelectorTap,
            ),
            Gaps.v32,
            MoodChartCard(
              title: S.of(context).monthlyMoodFlowTitle,
              content: MoodFlowChart(
                moodEntries: _moodEntries,
                isMonthly: true,
              ),
            ),
            Gaps.v32,
            MoodChartCard(
              title: S.of(context).monthlyMoodDistTitle,
              content: MoodDistChart(
                moodEntries: _moodEntries,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
