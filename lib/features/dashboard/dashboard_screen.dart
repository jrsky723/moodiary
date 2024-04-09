import 'package:flutter/material.dart';
import 'package:moodiary/common/widgets/date_selector_tab.dart';
import 'package:moodiary/constants/date.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/dashboard/mood_flow_chart.dart';
import 'package:moodiary/features/dashboard/models/mood_entry.dart';
import 'package:moodiary/utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  bool _isMonthly = true;
  final DateTime _now = DateTime.now();
  int _monthlyYear = DateTime.now().year;
  int _monthlyMonth = DateTime.now().month;
  int _yearlyYear = DateTime.now().year;
  final List<MoodEntry> _moodEntries =
      generateMoodEntries(DateTime.now().add(const Duration(days: -31)), 31);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: const Duration(milliseconds: 300),
    );

    _tabController?.addListener(() {
      setState(() {
        _isMonthly = _tabController?.index == 0;
      });
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Future<void> _onDateSelectorTap() async {
    final ScrollController scrollController = ScrollController();

    final int selectedIndex = _isMonthly
        ? (_now.year - _monthlyYear) * 12 + _now.month - _monthlyMonth
        : _now.year - _yearlyYear;

    final int itemCount = _isMonthly
        ? _now.month + (_now.year - minYear) * 12
        : _now.year - minYear + 1;

    const double itemExtent = 50;

    final double initialScrollOffset = selectedIndex * itemExtent;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(initialScrollOffset);
      }
    });

    DateTime? picked = await showModalBottomSheet<DateTime>(
      clipBehavior: Clip.antiAlias,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
                leading: const SizedBox(),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
                title: Text(
                  "${_isMonthly ? '월' : '연도'} 선택하기",
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                centerTitle: true,
                pinned: true,
              ),
              SliverFixedExtentList(
                itemExtent: itemExtent,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final int year = _isMonthly
                        ? index < _now.month
                            ? _now.year
                            : _now.year - (index - _now.month) ~/ 12 - 1
                        : _now.year - index;
                    final int month =
                        _isMonthly ? (_now.month - index - 1) % 12 + 1 : 1;

                    return ListTile(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(Sizes.size8),
                        ),
                      ),
                      tileColor: Colors.white,
                      selected: index == selectedIndex,
                      selectedTileColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      title: Text(
                        _isMonthly ? '$year년 $month월' : '$year년',
                        style: const TextStyle(fontSize: Sizes.size16),
                      ),
                      onTap: () {
                        Navigator.of(context).pop(DateTime(year, month));
                      },
                    );
                  },
                  childCount: itemCount,
                ),
              ),
            ],
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (_isMonthly) {
          _monthlyYear = picked.year;
          _monthlyMonth = picked.month;
        } else {
          _yearlyYear = picked.year;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '월간'),
            Tab(text: '연간'),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size20,
          ),
          child: TabBarView(
            controller: _tabController,
            children: [
              Column(
                children: [
                  DateSelectorTab(
                    text: "$_monthlyYear년 $_monthlyMonth월",
                    onTap: _onDateSelectorTap,
                  ),
                  Gaps.v32,
                  MoodFlowChart(moodEntries: _moodEntries),
                ],
              ),
              Column(
                children: [
                  DateSelectorTab(
                    text: "$_yearlyYear년",
                    onTap: _onDateSelectorTap,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
