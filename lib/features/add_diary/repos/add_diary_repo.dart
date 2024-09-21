// 데이터 유지및 데이터 가져오기만 하는 클래스

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/add_diary/models/add_diary_model.dart';

class AddDiaryRepository {
  // static final ApiService _apiService = ApiService();

  // AddDiaryRepository();
  // Future<void> postDiary(AddDiaryModel model) async {
  //   return _apiService.postDiary(model);
  // }

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createDiary(AddDiaryModel model) async {
    CollectionReference diaries =
        _db.collection('users').doc(model.uid).collection('diaries');

    DocumentReference docRef = diaries.doc();
    final String diaryId = docRef.id;

    await docRef.set({
      'uid': model.uid,
      'diaryId': diaryId,
      'content': model.content,
      'imageUrls': model.imageUrls,
      'isPublic': model.isPublic,
      'created_at': Timestamp.now(),
    });
  }
}

final addDiaryRepo = Provider((ref) => AddDiaryRepository());
