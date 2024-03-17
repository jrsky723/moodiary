import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodiary/features/calendar/calendar_screen.dart';

class MainNavigationScreen extends StatefulWidget {
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
    'xxx',
    'store',
    'settings',
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

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
            child: const Center(
              child: Text("Dashboard"),
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const Center(
              child: Text('Progress'),
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const Center(
              child: Text("Store"),
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const Center(
              child: Text("Settings"),
            ),
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
            icon: FaIcon(FontAwesomeIcons.store),
            label: 'Store',
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.gear),
            label: 'Settings',
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
