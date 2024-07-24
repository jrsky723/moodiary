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
import 'package:moodiary/utils/mood_utils.dart';
import 'package:moodiary/utils/date_utils.dart';

class YearlyDashboard extends StatefulWidget {
  const YearlyDashboard({super.key});

  @override
  State<YearlyDashboard> createState() => _YearlyDashboardState();
}

class _YearlyDashboardState extends State<YearlyDashboard> {
  final DateTime _now = DateTime.now();
  int _selectedYear = DateTime.now().year;
  late List<MoodEntry> _moodEntries = [];
  late List<MoodEntry> _monthlyMoodModes = [];

  @override
  initState() {
    super.initState();
    _moodEntries = generateMoodEntries(
      DateTime(_selectedYear, 1),
      daysInYear(_selectedYear),
    );
    _monthlyMoodModes = modeYearlyMoodEntries(
      _moodEntries,
    );
  }

  Future<void> _onDateSelectorTap() async {
    final ScrollController scrollController = ScrollController();

    final int selectedIndex = _now.year - _selectedYear;

    final int itemCount = _now.year - Date.minYear + 1;
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
      isMonthly: false,
      itemExtent: itemExtent,
      selectedIndex: selectedIndex,
      itemCount: itemCount,
      now: _now,
    );

    if (picked != null) {
      setState(() {
        _selectedYear = picked.year;
        _moodEntries = generateMoodEntries(
          DateTime(_selectedYear, 1),
          daysInYear(_selectedYear),
        );
        _monthlyMoodModes = modeYearlyMoodEntries(
          _moodEntries,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              DateSelectorTab(
                text: DateFormat.y().format(DateTime(_selectedYear)),
                onTap: _onDateSelectorTap,
              ),
              Gaps.v32,
              MoodChartCard(
                title: S.of(context).yearlyMoodFlowTitle,
                content: MoodFlowChart(
                    moodEntries: _monthlyMoodModes, isMonthly: false),
              ),
              Gaps.v32,
              MoodChartCard(
                title: S.of(context).yearlyMoodDistTitle,
                content: MoodDistChart(
                  moodEntries: _moodEntries,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
