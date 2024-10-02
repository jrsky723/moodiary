// 데이터 유지및 데이터 가져오기만 하는 클래스

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/diary/models/diary_model.dart';

class DiaryRepository {
  // static final ApiService _apiService = ApiService();

  // DiaryRepository();
  // Future<void> postDiary(Diarydiary diary) async {
  //   return _apiService.postDiary(diary);
  // }
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String generateDiaryId(String uid) {
    return _db.collection('users').doc(uid).collection('diaries').doc().id;
  }

  Future<List<String>> uploadImages({
    required String uid,
    required String diaryId,
    required List<File> images,
  }) async {
    // 이미지들을 업로드 하고, 이미지 url을 반환
    List<String> imageUrls = [];
    String baseUrl = 'users/$uid/diaries/$diaryId';
    final fileRef = _storage.ref().child(baseUrl);

    for (int i = 0; i < images.length; i++) {
      final file = images[i];
      String fileName = 'image$i';
      // 이미지 업로드
      await fileRef.child(fileName).putFile(file);

      // 이미지 url 가져오기 및 저장
      final url = '$baseUrl/$fileName';
      final String imageUrl = await getImageUrl(url);
      imageUrls.add(imageUrl);
    }
    return imageUrls;
  }

  Future<void> createDiary(DiaryModel diary) async {
    print('diary: ${diary.toJson()}');
    await _db
        .collection('users')
        .doc(diary.uid)
        .collection('diaries')
        .doc(diary.diaryId)
        .set({
      ...diary.toJson(),
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchDiaryByUserAndId(
    String uid,
    String diaryId,
  ) async {
    final query = _db
        .collection('users')
        .doc(uid)
        .collection('diaries')
        .where('diaryId', isEqualTo: diaryId);
    return query.get();
  }

  Future<String> getImageUrl(String url) async {
    return await _storage.ref().child(url).getDownloadURL();
  }
}

final diaryRepo = Provider((ref) => DiaryRepository());
