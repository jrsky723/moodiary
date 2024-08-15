import 'package:flutter/material.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/dashboard/models/mood_entry.dart';
import 'package:moodiary/features/dashboard/widgets/circumplex_model_card.dart';
import 'package:moodiary/features/dashboard/widgets/distribution_chart_card.dart';
import 'package:moodiary/features/dashboard/widgets/flow_chart_card.dart';
import 'package:moodiary/utils/mood_utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController _scrollController = ScrollController();

  List<MoodEntry> moodEntries = generateMoodEntries(
    DateTime.now().subtract(
      const Duration(days: 28),
    ),
    28,
  );

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            const SliverAppBar(
              title: Text('Dashboard'),
              pinned: true,
              floating: true,
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.black,
            ),
          ];
        },
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildMoodChartSection(
                height: 200.0,
              ),
            ),
            const SliverToBoxAdapter(
              child: Gaps.v16,
            ),
            SliverToBoxAdapter(
              child: _buildFlowChartSection(
                height: 200.0,
              ),
            ),
            const SliverToBoxAdapter(
              child: Gaps.v16,
            ),
            SliverToBoxAdapter(
              child: _buildDistributionChartSection(
                height: 540.0,
              ),
            ),
          ],
        ),
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
          color: Colors.white,
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
  }) {
    return _buildSectionContainer(
      height: height,
      child: PageView(
        children: [
          CircumplexModelCard(
            titleText: Text(
              'Circumplex Model',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitleText: Text(
              '최근 28일 감정 분포',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            moodOffsets: [
              for (final moodEntry in moodEntries) moodEntry.offset,
            ],
          ),
          Column(
            children: [
              Text(
                'Mood Cloud',
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
  }) {
    return _buildSectionContainer(
      height: height,
      child: PageView(
        children: [
          FlowChartCard(
            moodEntries: moodEntries,
            titleText: Text(
              'Pleasantness - Unpleasantness',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          FlowChartCard(
            moodEntries: moodEntries,
            titleText: Text(
              'Activation - Deactivation',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            isXAxis: false,
          ),
        ],
      ),
    );
  }

  Widget _buildDistributionChartSection({
    required double height,
  }) {
    return _buildSectionContainer(
      height: height,
      child: DistributionChartCard(
        moodEntries: moodEntries,
        titleText: Text(
          'Mood Distribution',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
