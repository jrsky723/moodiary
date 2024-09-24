// 데이터 유지및 데이터 가져오기만 하는 클래스

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiaryRepository {
  // static final ApiService _apiService = ApiService();

  // DiaryRepository();
  // Future<void> postDiary(DiaryModel model) async {
  //   return _apiService.postDiary(model);
  // }
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String generateDiaryId(String uid) {
    return _db.collection('users').doc(uid).collection('diaries').doc().id;
  }

  Future<List<String>> uploadImage(
      String uid, String diaryId, List<String> imagePaths) async {
    List<String> imageUrls = [];
    String url = '$uid/diaries/$diaryId';

    final fileRef = _storage.ref().child(url);
    for (int i = 0; i < imagePaths.length; i++) {
      final file = File(imagePaths[i]);
      String fileName = 'image$i';
      await fileRef.child(fileName).putFile(file);
      imageUrls.add('$url/$fileName');
    }
    return imageUrls;
  }

  Future<void> createDiary(Map<String, dynamic> model) async {
    // CollectionReference diaries =
    //     _db.collection('users').doc(model.uid).collection('diaries');
    // DocumentReference docRef = diaries.doc();

    // fire Storage의 경로로 imageUrl 생성
    List<String> imageUrls =
        await uploadImage(model['uid'], model['diaryId'], model['imageUrls']);

    model['imageUrls'] = imageUrls;
    await _db
        .collection('users')
        .doc(model['uid'])
        .collection('diaries')
        .doc(model['diaryId'])
        .set({
      ...model,
      'created_at': Timestamp.now(),
      'updated_at': Timestamp.now(),
    });

    // await docRef.set({
    //   // TODO: authentication 구성하고 uid로 변경해야됨
    //   'uid': model.uid,
    //   'diaryId': model.diaryId,
    //   'content': model.content,
    //   // fire storage에 저장된 이미지 url
    //   'imageUrls': imageUrls,
    //   'isPublic': model.isPublic,
    //   'created_at': Timestamp.now(),
    //   'updated_at': Timestamp.now(),
    // });
  }

  Future<Map<String, dynamic>?> getDiaryByDate(String uid, String date) async {
    final snapshot = await _db
        .collection('users')
        .doc(uid)
        .collection('diaries')
        .where('date', isEqualTo: date)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data();
    } else {
      return null;
    }
  }

  Future<String> getImageUrl(String url) async {
    return await _storage.ref().child(url).getDownloadURL();
  }
}

final diaryRepo = Provider((ref) => DiaryRepository());
