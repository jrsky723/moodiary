import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/common/main_navigation_screen.dart';
import 'package:moodiary/constants/colors.dart';
import 'package:moodiary/constants/sizes.dart';
import 'package:moodiary/features/settings/repos/settings_repos.dart';
import 'package:moodiary/features/settings/view_models/settings_view_model.dart';
import 'package:moodiary/theme/navigation_theme.dart';
import 'package:moodiary/theme/switch_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final repository = SettingsRepos(preferences);

  runApp(ProviderScope(
    overrides: [
      settingsProvider.overrideWith(
        () => SettingsViewModel(repository),
      ),
    ],
    child: const Moodiary(),
  ));
}

class Moodiary extends ConsumerWidget {
  const Moodiary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return MaterialApp(
      title: 'Moodiary',
      themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        textTheme: Typography.blackMountainView,
        brightness: Brightness.light,
        dialogBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: Colors.green.shade50,
          primarySwatch: customPrimarySwatch,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade50,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: Sizes.size20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: Typography.whiteMountainView,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: Colors.grey.shade900,
          primarySwatch: customPrimarySwatch,
        ),
        primaryColor: customPrimarySwatch,
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Colors.grey.shade900,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: Sizes.size20,
            fontWeight: FontWeight.bold,
          ),
        ),
        listTileTheme: const ListTileThemeData(
          textColor: Colors.white,
        ),
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            navigationBarTheme: navigationBarThemeData(context),
            switchTheme: switchThemeData(context),
          ),
          child: child ?? const SizedBox(),
        );
      },
      home: const MainNavigationScreen(tab: 'calendar'),
    );
  }
}
