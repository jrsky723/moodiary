import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodiary/common/main_navigation_screen.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/authentication/views/log_in_screen.dart';
import 'package:moodiary/features/authentication/views/sign_up_screen.dart';
import 'package:moodiary/features/diary/views/add_diary_screen.dart';
import 'package:moodiary/features/diary/views/diary_detail_screen.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: '/${MainNavigationScreen.initialTab}',
      debugLogDiagnostics: true,
      redirect: (context, state) {
        final isLoggIned = ref.read(authRepo).isLoggedIn;
        if (!isLoggIned) {
          if (state.matchedLocation != SignUpScreen.routeUrl &&
              state.matchedLocation != LogInScreen.routeUrl) {
            return SignUpScreen.routeUrl;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          path: LogInScreen.routeUrl,
          name: LogInScreen.routeName,
          builder: (context, state) {
            return const LogInScreen();
          },
        ),
        GoRoute(
          path: SignUpScreen.routeUrl,
          name: SignUpScreen.routeName,
          builder: (context, state) {
            return const SignUpScreen();
          },
        ),
        GoRoute(
          path: "/:tab(calendar|dashboard|community|user)",
          name: MainNavigationScreen.routeName,
          builder: (context, state) {
            final String tab = state.pathParameters['tab']!;
            return MainNavigationScreen(tab: tab);
          },
        ),
        GoRoute(
          path: AddDiaryScreen.routeUrl,
          name: AddDiaryScreen.routeName,
          builder: (context, state) {
            final date = state.extra as DateTime?;
            return AddDiaryScreen(date: date);
          },
        ),
        GoRoute(
          path: DiaryDetailScreen.routeUrl,
          name: DiaryDetailScreen.routeName,
          builder: (context, state) {
            final String diaryId = state.pathParameters['diaryId']!;
            final date = state.extra as DateTime;
            return DiaryDetailScreen(diaryId: diaryId, date: date);
          },
        )
      ],
    );
  },
);
