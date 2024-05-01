import 'package:flutter/material.dart';
import 'package:moodiary/features/dashboard/monthly_dashboard.dart';
import 'package:moodiary/features/dashboard/yearly_dashboard.dart';
import 'package:moodiary/generated/l10n.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: S.of(context).monthlyTab),
            Tab(text: S.of(context).yearlyTab),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            MonthlyDashboard(),
            YearlyDashboard(),
          ],
        ),
      ),
    );
  }
}
