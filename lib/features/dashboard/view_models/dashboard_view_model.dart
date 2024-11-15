import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/dashboard/models/mood_entry.dart';
import 'package:moodiary/features/dashboard/repos/dashboard_repo.dart';

class DashboardViewModel extends AutoDisposeAsyncNotifier<List<MoodEntry>> {
  late final DashboardRepository _repo;
  late List<MoodEntry> _list;

  @override
  FutureOr<List<MoodEntry>> build() async {
    _repo = ref.read(dashboardRepo);
    _list = await _fetchMoodEntries();
    return _list;
  }

  Future<List<MoodEntry>> _fetchMoodEntries(
      {DateTime? start, DateTime? end}) async {
    final startDate =
        start ?? DateTime.now().subtract(const Duration(days: 28));
    final endDate = end ?? DateTime.now();

    final user = ref.read(authRepo).user;
    final uid = user?.uid;
    final result =
        await _repo.fetchOffsetList(uid: uid!, start: startDate, end: endDate);

    final entries = result.map((entry) {
      return MoodEntry.fromJson(entry);
    });

    return entries.toList();
  }

  Future<void> fetchMoodEntries({
    required DateTime start,
    required DateTime end,
  }) async {
    state = const AsyncValue.loading();
    final entries = await _fetchMoodEntries(start: start, end: end);
    state = AsyncValue.data(entries);
  }
}

final dashboardProvider =
    AutoDisposeAsyncNotifierProvider<DashboardViewModel, List<MoodEntry>>(
  () => DashboardViewModel(),
);
