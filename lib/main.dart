import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/constants/colors.dart';
import 'package:moodiary/constants/text_themes.dart';
import 'package:moodiary/features/diary/view_models/add_diary_view_model.dart';
import 'package:moodiary/features/settings/repos/settings_repos.dart';
import 'package:moodiary/features/settings/view_models/settings_view_model.dart';
import 'package:moodiary/firebase_options.dart';
import 'package:moodiary/router.dart';
import 'package:moodiary/theme/navigation_theme.dart';
import 'package:moodiary/theme/switch_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  final preferences = await SharedPreferences.getInstance();
  final repository = SettingsRepos(preferences);
  await dotenv.load();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      overrides: [
        settingsProvider.overrideWith(
          () => SettingsViewModel(repository),
        ),
        addDiaryProvider.overrideWith(
          // () => AddDiaryViewModel(addDiaryRepo),
          () => AddDiaryViewModel(),
        ),
      ],
      child: const Moodiary(),
    ),
  );
}

class Moodiary extends ConsumerWidget {
  const Moodiary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return MaterialApp.router(
      routerConfig: ref.read(routerProvider),
      title: 'Moodiary',
      themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: settings.isEnglish
          ? const Locale('en', 'US')
          : const Locale('ko', 'KR'),
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        textTheme: CustomTextThemes.darkTextTheme,
        brightness: Brightness.light,
        dialogBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: customPrimarySwatch,
          surface: Colors.green.shade50,
          brightness: Brightness.light,
        ),
        primaryColor: customPrimarySwatch,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade50,
          centerTitle: true,
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: customPrimarySwatch,
          unselectedLabelColor: Colors.black,
          dividerColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        textTheme: CustomTextThemes.whiteTextTheme,
        brightness: Brightness.dark,
        dialogBackgroundColor: Colors.grey.shade900,
        colorScheme: ColorScheme.fromSeed(
          seedColor: customPrimarySwatch,
          surface: Colors.grey.shade900,
          brightness: Brightness.dark,
        ),
        primaryColor: customPrimarySwatch,
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Colors.grey.shade900,
          centerTitle: true,
        ),
        listTileTheme: const ListTileThemeData(
          textColor: Colors.white,
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: customPrimarySwatch,
          unselectedLabelColor: Colors.white,
          dividerColor: Colors.black,
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
    );
  }
}
