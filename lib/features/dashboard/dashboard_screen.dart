import 'package:flutter/material.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/dashboard/models/mood_entry.dart';
import 'package:moodiary/features/dashboard/widgets/circumplex_model_card.dart';
import 'package:moodiary/features/dashboard/widgets/flow_chart_card.dart';
import 'package:moodiary/utils/mood_utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<MoodEntry> moodEntries = generateMoodEntries(
    DateTime.now().subtract(
      const Duration(days: 28),
    ),
    28,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '감정 분석',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size16,
        ),
        child: ListView(
          children: [
            Gaps.v16,
            _buildMoodChartSection(
              height: 200.0,
            ),
            Gaps.v16,
            _buildFlowChartSection(
              height: 200.0,
            ),
            Gaps.v16,
            _buildDistributionChartSection(
              height: 500.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodChartSection({
    required double height,
  }) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size18,
        vertical: Sizes.size18,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizes.size16),
      ),
      child: PageView(
        children: [
          CircumplexModelCard(
            moodOffsets: [
              for (final moodEntry in moodEntries) moodEntry.offset,
            ],
          ),
          Column(
            children: [
              const Text(
                'Mood Cloud',
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.bold,
                ),
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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size18,
        vertical: Sizes.size20,
      ),
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizes.size16),
      ),
      child: PageView(
        children: [
          FlowChartCard(moodEntries: moodEntries),
          FlowChartCard(
            moodEntries: moodEntries,
            isXAxis: false,
          ),
        ],
      ),
    );
  }

  Widget _buildDistributionChartSection({
    required double height,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size18,
        vertical: Sizes.size20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizes.size16),
      ),
      child: Column(
        children: [
          Gaps.v12,
          SizedBox(
            height: height,
            child: const Placeholder(),
          ),
        ],
      ),
    );
  }
}
