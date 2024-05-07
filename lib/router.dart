import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodiary/common/main_navigation_screen.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: '/${MainNavigationScreen.initialTab}',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: MainNavigationScreen.path,
          name: MainNavigationScreen.routeName,
          builder: (context, state) {
            final String tab = state.pathParameters['tab']!;
            return MainNavigationScreen(tab: tab);
          },
        ),
      ],
    );
  },
);
