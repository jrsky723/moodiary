import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/diary/models/diary_model.dart';
import 'package:moodiary/features/diary/repos/diary_repo.dart';

// class DiaryDetailViewModel extends AsyncNotifier<DiaryModel> {
//   late final DiaryRepository _repository;
//   final String uid = '1';

//   @override
//   Future<DiaryModel> build(String date) async {
//     _repository = ref.read(diaryRepo);

//     final diary = await _repository.getDiaryByDate(uid, date);
//     return diary ?? DiaryModel.empty();
//   }
// }

class DiaryDetailViewModel extends FamilyAsyncNotifier<DiaryModel, DateTime> {
  late final DiaryRepository _repository;

  @override
  FutureOr<DiaryModel> build(DateTime date) async {
    _repository = ref.read(diaryRepo);
    const uid = '1'; // TODO: authentication 구성하고 uid로 변경해야됨
    final diary = await _repository.fetchDiaryByUserAndDate(uid, date);
    // json 내부도 함꼐 print 해주세요
    print('diary: $diary');

    if (diary != null) {
      // date는 timestamp 형식으로 되어있어서, dateTime으로 변환해주는 코드가 필요합니다.
      diary['date'] = DateTime.fromMillisecondsSinceEpoch(
          (diary['date'] as Timestamp).millisecondsSinceEpoch);
      diary['imageUrls'] = List<String>.from(diary['imageUrls']);
      return DiaryModel.fromJson(diary);
    } else {
      return DiaryModel.empty();
    }
  }
}

final diaryDetailProvider =
    AsyncNotifierProvider.family<DiaryDetailViewModel, DiaryModel, DateTime>(
  () => DiaryDetailViewModel(),
);
