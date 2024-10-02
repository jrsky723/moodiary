import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/dashboard/models/mood_entry.dart';
import 'package:moodiary/features/dashboard/view_models/dashboard_view_model.dart';
import 'package:moodiary/features/dashboard/views/widgets/circumplex_model_card.dart';
import 'package:moodiary/features/dashboard/views/widgets/distribution_chart_card.dart';
import 'package:moodiary/features/dashboard/views/widgets/flow_chart_card.dart';
import 'package:moodiary/generated/l10n.dart';
import 'package:moodiary/utils/build_utils.dart';
import 'package:moodiary/utils/mood_utils.dart';

class DateRangeOption {
  final String label;
  final DateTime startDate;
  final DateTime endDate;

  DateRangeOption({
    required this.label,
    required this.startDate,
    required this.endDate,
  });
}

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final ScrollController _scrollController = ScrollController();
  // 시작 날짜(startDate), 끝 날짜(endDate) options에 추가 (사용자 선택 가능 날짜)
  //  가로 리스트 형식으로, 기간을 선택할 수 있음 (7일, 28일, 90일, 365일 | 최근 3개월간의 월별 (ex 8월, 7월, 6월) | 최근 2년간 연도별 (ex 2023년, 2022년))
  // late List<List<DateRangeOption>> _options;
  late List<DateRangeOption> _daysOptions;
  late List<DateRangeOption> _monthsOptions;
  late List<DateRangeOption> _yearsOptions;
  final List<MoodEntry> _defaultMoodEntries = generateMoodEntries(
    startDate: DateTime.now().subtract(const Duration(days: 28)),
    days: 28,
  );
  int _selectedOptionIndex = 1; // 28일
  bool _isDataEmpty = false;
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _startDate = DateTime(now.year, now.month, now.day - 28 + 1);
    _endDate = DateTime(now.year, now.month, now.day);
  }

  @override
  void didChangeDependencies() {
    // initState 이후에 localizations을 실행하기 위해
    super.didChangeDependencies();
    _initOptions();
  }

  void _initOptions() {
    final now = DateTime.now();

    _daysOptions = [
      for (final days in [7, 28, 90, 365])
        DateRangeOption(
          label: S.of(context).days(days),
          startDate: DateTime(now.year, now.month, now.day - days + 1),
          endDate: DateTime(now.year, now.month, now.day),
        ),
    ];

    _monthsOptions = [
      for (int i = 0; i < 3; i++)
        DateRangeOption(
          label: DateFormat.MMM().format(DateTime(now.year, now.month - i)),
          startDate: DateTime(now.year, now.month - i, 1),
          endDate: DateTime(now.year, now.month - i + 1, 0),
        ),
    ];

    _yearsOptions = [
      for (int i = 0; i < 2; i++)
        DateRangeOption(
          label: DateTime(now.year - i).year.toString(),
          startDate: DateTime(now.year - i, 1, 1),
          endDate: DateTime(now.year - i, 12, 31),
        ),
    ];
  }

  void _onOptionButtonPressed(int index) {
    setState(() {
      _selectedOptionIndex = index;
      final selectedOption = _getSelectedOption();
      _startDate = selectedOption.startDate;
      _endDate = selectedOption.endDate;
      ref.read(dashboardProvider.notifier).fetchMoodEntries(
            start: _startDate,
            end: _endDate,
          );
    });
  }

  DateRangeOption _getSelectedOption() {
    if (_selectedOptionIndex < _daysOptions.length) {
      return _daysOptions[_selectedOptionIndex];
    } else if (_selectedOptionIndex <
        _daysOptions.length + _monthsOptions.length) {
      return _monthsOptions[_selectedOptionIndex - _daysOptions.length];
    } else {
      return _yearsOptions[
          _selectedOptionIndex - _daysOptions.length - _monthsOptions.length];
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Text(S.of(context).dashboard),
                  pinned: true,
                  floating: true,
                  surfaceTintColor: Colors.transparent,
                  shadowColor: Colors.black,
                  bottom: PreferredSize(
                    // 최근 몇일간의 기분을 보여줄지 선택 가능
                    //  가로 리스트 형식으로, 기간을 선택할 수 있음 (7일, 28일, 90일, 365일 | 최근 3개월간의 월별 (ex 8월, 7월, 6월) | 최근 2년간 연도별 (ex 2023년, 2022년))
                    // 스와이프로 선택 가능
                    preferredSize: const Size.fromHeight(Sizes.size52),

                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: Sizes.size12,
                        right: Sizes.size12,
                        bottom: Sizes.size4,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // days options
                            for (int i = 0; i < _daysOptions.length; i++) ...[
                              _buildOptionButton(_daysOptions[i], i),
                            ],
                            _buildSeperator(),
                            // months options
                            for (int i = 0; i < _monthsOptions.length; i++) ...[
                              _buildOptionButton(
                                  _monthsOptions[i], i + _daysOptions.length),
                            ],
                            _buildSeperator(),
                            // years options
                            for (int i = 0; i < _yearsOptions.length; i++) ...[
                              _buildOptionButton(
                                  _yearsOptions[i],
                                  i +
                                      _daysOptions.length +
                                      _monthsOptions.length),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: ref.watch(dashboardProvider).when(
                  data: (moodEntries) {
                    _isDataEmpty = moodEntries.isEmpty;
                    if (_isDataEmpty) moodEntries = _defaultMoodEntries;
                    return Stack(
                      children: [
                        CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: _buildMoodChartSection(
                                height: 200.0,
                                moodEntries: moodEntries,
                              ),
                            ),
                            const SliverToBoxAdapter(
                              child: Gaps.v16,
                            ),
                            SliverToBoxAdapter(
                              child: _buildFlowChartSection(
                                height: 200.0,
                                moodEntries: moodEntries,
                                isDefault: _isDataEmpty,
                              ),
                            ),
                            const SliverToBoxAdapter(
                              child: Gaps.v16,
                            ),
                            SliverToBoxAdapter(
                              child: _buildDistributionChartSection(
                                height: 540.0,
                                moodEntries: moodEntries,
                              ),
                            ),
                          ],
                        ),
                        if (_isDataEmpty)
                          IgnorePointer(
                            ignoring: !_isDataEmpty,
                            child: Container(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                      ],
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  error: (error, stackTrace) => Center(
                    child: Text('Error: $error'),
                  ),
                ),
          ),
          // data가 없을 때, 어두워지게 하기 (애니메이션)
          if (_isDataEmpty)
            Center(
              child: Text(
                "데이터가 없습니다.",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.grey.shade300,
                    ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(DateRangeOption option, int index) {
    final isSelected = index == _selectedOptionIndex;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size4,
      ),
      child: ElevatedButton(
        onPressed: () => _onOptionButtonPressed(index),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.size8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size8,
            vertical: Sizes.size8,
          ),
          backgroundColor: isSelected
              ? Theme.of(context).primaryColor
              : isDarkMode(context)
                  ? Colors.grey[800]
                  : Colors.grey[200],
          foregroundColor: isSelected ? Colors.white : Colors.black87,
        ),
        child: Text(option.label),
      ),
    );
  }

  Widget _buildSeperator() {
    return const SizedBox(
      height: Sizes.size30,
      child: VerticalDivider(
        color: Colors.grey,
        thickness: 1.5,
      ),
    );
  }

  Widget _buildSectionContainer({
    required Widget child,
    required double height,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size16,
        vertical: Sizes.size8,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size18,
          vertical: Sizes.size20,
        ),
        height: height,
        decoration: BoxDecoration(
          color: isDarkMode(context) ? Colors.transparent : Colors.white,
          borderRadius: BorderRadius.circular(Sizes.size16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5,
              offset: Offset(0, 1.5),
            ),
          ],
        ),
        child: child,
      ),
    );
  }

  Widget _buildMoodChartSection({
    required double height,
    required List<MoodEntry> moodEntries,
  }) {
    return _buildSectionContainer(
      height: height,
      child: PageView(
        children: [
          CircumplexModelCard(
            titleText: Text(
              S.of(context).circumplexModel,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitleText: Text(
              S.of(context).dashboardDescription(
                    moodEntries.length > 30 ? 30 : moodEntries.length,
                  ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            moodOffsets: [
              for (final moodEntry in moodEntries) moodEntry.offset,
            ],
          ),
          Column(
            children: [
              Text(
                S.of(context).moodCloud,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Gaps.v8,
              Expanded(
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/wordcloud.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFlowChartSection({
    required double height,
    required List<MoodEntry> moodEntries,
    required bool isDefault,
  }) {
    final startDate = isDefault ? _defaultMoodEntries.first.date : _startDate;
    final endDate = isDefault ? _defaultMoodEntries.last.date : _endDate;
    return _buildSectionContainer(
      height: height,
      child: PageView(
        children: [
          FlowChartCard(
            moodEntries: moodEntries,
            titleText: Text(
              '${S.of(context).positive} - ${S.of(context).negative}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            startDate: startDate,
            endDate: endDate,
          ),
          FlowChartCard(
            moodEntries: moodEntries,
            titleText: Text(
              '${S.of(context).active} - ${S.of(context).passive}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            startDate: startDate,
            endDate: endDate,
            isXAxis: false,
          ),
        ],
      ),
    );
  }

  Widget _buildDistributionChartSection({
    required double height,
    required List<MoodEntry> moodEntries,
  }) {
    return _buildSectionContainer(
      height: height,
      child: DistributionChartCard(
        moodEntries: moodEntries,
        titleText: Text(
          S.of(context).moodDistribution,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
