import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/authentication/views/sign_up_screen.dart';
import 'package:moodiary/features/settings/view_models/settings_view_model.dart';
import 'package:moodiary/features/users/view_models/user_profile_view_model.dart';
import 'package:moodiary/generated/l10n.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  void _onSignOut() {
    ref.read(authRepo).signOut();
    context.go(SignUpScreen.routeUrl);
  }

  void _onDeletePressed() {
    // 탈퇴 버튼을 눌렀을 때, 정말로 탈퇴할 것인지 확인하는 다이얼로그 후에 탈퇴

    // 다이얼로그
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).deleteAccount),
          content: Text(S.of(context).deleteAccountMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: _onDelete,
              child: Text(S.of(context).delete),
            ),
          ],
        );
      },
    );
  }

  void _onDelete() {
    ref.read(userProfileProvider.notifier).deleteProfile();
    context.go(SignUpScreen.routeUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // Sign out 버튼
            Center(
              child: TextButton(
                onPressed: _onSignOut,
                child: Text(
                  S.of(context).signOut,
                  style: const TextStyle(
                    color: Colors.red, // 로그아웃 버튼 빨간색 텍스트
                  ),
                ),
              ),
            ),
            // 탈퇴 버튼
            Center(
              child: TextButton(
                onPressed: _onDeletePressed,
                child: Text(
                  S.of(context).deleteAccount,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
