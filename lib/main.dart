import 'package:flutter/material.dart';
import 'package:moodiary/common/main_navigation_screen.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/theme/navigation_theme.dart';

void main() {
  runApp(const Moodiary());
}

class Moodiary extends StatelessWidget {
  const Moodiary({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moodiary',
      theme: ThemeData(
        dialogBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF1FBF88),
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: Colors.green.shade50,
          primarySwatch: Colors.grey,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade50,
          elevation: 0,
        ),
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            navigationBarTheme: NavigationBarThemeData(
              height: Sizes.size64,
              elevation: 0,
              backgroundColor: Colors.white,
              indicatorColor: Colors.transparent,
              overlayColor: MaterialStateProperty.resolveWith(
                (states) => Colors.transparent,
              ),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              iconTheme: MaterialStateProperty.resolveWith(
                (states) => navigationIconStyle(states, context),
              ),
            ),
          ),
          child: child ?? const SizedBox(),
        );
      },
      home: const MainNavigationScreen(tab: 'calendar'),
    );
  }
}
