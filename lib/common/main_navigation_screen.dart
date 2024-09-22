import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:moodiary/features/add_diary/views/add_diary_screen.dart';
import 'package:moodiary/features/calendar/calendar_screen.dart';
import 'package:moodiary/features/community/views/community_screen.dart';
import 'package:moodiary/features/dashboard/dashboard_screen.dart';
import 'package:moodiary/features/users/views/user_profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = 'mainNavigation';
  static const String initialTab = 'calendar';

  final String tab;

  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    'calendar',
    'dashboard',
    'xxxx',
    'community',
    'user',
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  final int _addDiaryIndex = 2;

  void _onDestinationSelected(int index) {
    if (index == _addDiaryIndex) {
      context.pushNamed(AddDiaryScreen.routeName);
    } else {
      context.go('/${_tabs[index]}');
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const CalendarScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DashboardScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const CommunityScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.calendarDay),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.chartSimple),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.circlePlus),
            label: 'Add Diary',
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.users),
            label: 'Community',
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.user),
            label: 'Profile',
            selectedIcon: FaIcon(FontAwesomeIcons.solidUser),
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}
