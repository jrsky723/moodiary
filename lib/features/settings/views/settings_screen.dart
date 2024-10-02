import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/authentication/views/sign_up_screen.dart';
import 'package:moodiary/features/settings/view_models/settings_view_model.dart';
import 'package:moodiary/generated/l10n.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Localizations.override(
      context: context,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).settings),
        ),
        body: Center(
          child: ListView(
            children: [
              SwitchListTile.adaptive(
                title: Text(
                  S.of(context).darkModeTitle,
                ),
                subtitle: Opacity(
                  opacity: 0.5,
                  child: Text(
                    S.of(context).darkModeSubtitle,
                  ),
                ),
                value: ref.watch(settingsProvider).isDarkMode,
                onChanged: (value) =>
                    ref.read(settingsProvider.notifier).setDarkMode(value),
              ),
              SwitchListTile.adaptive(
                title: Text(S.of(context).englishModeTitle),
                subtitle: Opacity(
                  opacity: 0.5,
                  child: Text(S.of(context).englishModeSubtitle),
                ),
                value: ref.watch(settingsProvider).isEnglish,
                onChanged: (value) {
                  ref.read(settingsProvider.notifier).setEnglish(value);
                },
              ),
              // sign out
              ListTile(
                title: const Text("sign out"),
                onTap: () {
                  ref.read(authRepo).signOut();
                  context.goNamed(SignUpScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
