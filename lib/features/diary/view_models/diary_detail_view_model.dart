import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/diary/models/diary_model.dart';
import 'package:moodiary/features/diary/repos/diary_repo.dart';

class DiaryDetailViewModel extends FamilyAsyncNotifier<DiaryModel, String> {
  late final DiaryRepository _repo;
  late DiaryModel _diary;

  @override
  FutureOr<DiaryModel> build(String arg) async {
    _repo = ref.read(diaryRepo);
    _diary = await _fetchDiaryById(arg);
    return _diary;
  }

  Future<DiaryModel> _fetchDiaryById(String diaryId) async {
    final user = ref.read(authRepo).user;
    final uid = user?.uid;
    final result = await _repo.fetchDiaryByUserAndId(uid!, diaryId);
    if (result.docs.isEmpty) {
      throw Exception('Diary not found');
    }
    final diary = DiaryModel.fromJson(json: result.docs.first.data());
    return diary;
  }
}

final diaryDetailProvider =
    AsyncNotifierProvider.family<DiaryDetailViewModel, DiaryModel, String>(
  () => DiaryDetailViewModel(),
);
