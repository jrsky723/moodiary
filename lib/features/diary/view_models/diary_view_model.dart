import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/authentication/repos/authentication_repo.dart';
import 'package:moodiary/features/diary/models/diary_model.dart';
import 'package:moodiary/features/diary/repos/diary_repo.dart';

class DiaryViewModel extends FamilyAsyncNotifier<DiaryModel, String> {
  late final DiaryRepository _repo;
  late DiaryModel _diary;
  @override
  FutureOr<DiaryModel> build(String arg) async {
    _repo = ref.read(diaryRepo);
    _diary = await _fetchDiaryById(arg);
    return _diary;
  }

  Future<DiaryModel> _fetchDiaryById(diaryId) async {
    final user = ref.read(authRepo).user;
    final uid = user?.uid;
    final result = await _repo.fetchDiaryByUserAndId(uid!, diaryId);

    final diary = DiaryModel.fromJson(json: result);
    return diary;
  }

  Future<void> updateDiary({
    required int diaryId,
    required String content,
    required List<String> imageUrls,
    required bool isPublic,
  }) async {
    state = const AsyncValue.loading();
    final user = ref.read(authRepo).user;
    final uid = user!.uid;
    try {
      await _repo.updateDiary(
        uid,
        diaryId,
        {
          'content': content,
          'imageUrls': imageUrls,
          'isPublic': isPublic,
        },
      );
      _diary = _diary.copyWith(
        isAnalyzed: false,
        content: content,
        imageUrls: imageUrls,
        isPublic: isPublic,
      );
      state = AsyncValue.data(_diary);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteDiary(int diaryId) async {
    state = const AsyncValue.loading();
    final uid = ref.read(authRepo).user!.uid;
    try {
      await _repo.deleteDiary(uid, diaryId);
      state = AsyncValue.data(DiaryModel.empty());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> analyzeDiary(BuildContext context) async {
    state = const AsyncValue.loading();
    final uid = ref.read(authRepo).user!.uid;
    try {
      final result = await _repo.analyzeDiary(uid, _diary);
      if (result['status'] == 'error') {
        final snackBarController = ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
          ),
        );
        // SnackBar가 닫힐 때 상태를 업데이트
        snackBarController.closed.then((reason) {
          if (reason == SnackBarClosedReason.timeout ||
              reason == SnackBarClosedReason.swipe ||
              reason == SnackBarClosedReason.action) {
            state = AsyncValue.data(_diary);
          }
        });
        return;
      }
      _diary = _diary.copyWith(
        offsetX: result['offsetX'],
        offsetY: result['offsetY'],
        isAnalyzed: true,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
        ),
      );
      state = AsyncValue.data(_diary);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final diaryProvider =
    AsyncNotifierProvider.family<DiaryViewModel, DiaryModel, String>(
  () => DiaryViewModel(),
);
