import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/settings/view_models/settings_view_model.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: ListView(
          children: [
            SwitchListTile.adaptive(
              title: const Text('Dark mode'),
              value: ref.watch(settingsProvider).isDarkMode,
              onChanged: (value) =>
                  ref.read(settingsProvider.notifier).setDarkMode(value),
            ),
            SwitchListTile.adaptive(
              title: const Text('English'),
              value: ref.watch(settingsProvider).isEnglish,
              onChanged: (value) =>
                  ref.read(settingsProvider.notifier).setEnglish(value),
            ),
          ],
        ),
      ),
    );
  }
}
