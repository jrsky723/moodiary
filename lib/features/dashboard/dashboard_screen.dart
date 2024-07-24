import 'package:flutter/material.dart';
import 'package:moodiary/constants/gaps.dart';
import 'package:moodiary/constants/sizes.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
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

  Widget _buildFlowChartSection({
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
