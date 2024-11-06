import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/diary/models/diary_model.dart';
import 'package:http/http.dart' as http;

class DiaryRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _apiBaseUrl = '${dotenv.env['API_BASE_URL']}/diary';
  String generateDiaryId(String uid) {
    return _db.collection('users').doc(uid).collection('diaries').doc().id;
  }

  Future<List<String>> uploadImages({
    required String uid,
    required String diaryId,
    required List<File> images,
  }) async {
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
    await _db
        .collection('users')
        .doc(diary.uid)
        .collection('diaries')
        .doc(diary.diaryId.toString())
        .set({
      ...diary.toJson(),
    });
  }

  Future<void> updateDiary(
      String uid, String diaryId, Map<String, dynamic> data) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('diaries')
        .doc(diaryId)
        .update(data);
  }

  Future<void> updateCommunityDiary(
    String diaryId,
    Map<String, dynamic> data,
  ) async {
    await _db.collection('community').doc(diaryId).update(data);
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

  Future<void> deleteUserDiariesByDiaryIds(
      String uid, List<String> diaryIds) async {
    List<String> imagePaths = [];

    final diaries = await _db
        .collection('users')
        .doc(uid)
        .collection('diaries')
        .where('diaryId', whereIn: diaryIds)
        .get();

    for (final diary in diaries.docs) {
      final imageUrls =
          (diary.data()['imageUrls'] as List<dynamic>).cast<String>();

      // 이미지 삭제
      for (final imageUrl in imageUrls) {
        final path = extractPathFromUrl(imageUrl);
        imagePaths.add(path);
      }

      // 다이어리 문서 삭제
      await _db
          .collection('users')
          .doc(uid)
          .collection('diaries')
          .doc(diary.data()['diaryId'])
          .delete();
    }
    imagePaths.forEach((imageUrl) async {
      await _storage.ref().child(imageUrl).delete();
    });
  }

  String extractPathFromUrl(String url) {
    final regex = RegExp(r'o\/(.*?)\?');
    final match = regex.firstMatch(url);
    if (match != null) {
      // 경로 추출 후 디코딩
      return Uri.decodeComponent(match.group(1)!);
    }
    return '';
  }

  Future<void> deleteCommunityDiariesByDiaryIds(List<String> diaryIds) async {
    final batch = _db.batch();

    final diaries = await _db
        .collection('community')
        .where(
          'diaryId',
          whereIn: diaryIds,
        )
        .get();

    for (final diary in diaries.docs) {
      final diaryId = diary.data()['diaryId'];
      final ref = _db.collection('community').doc(diaryId);
      batch.delete(ref);
    }
    await batch.commit();
  }

  Future<List<Map<String, dynamic>>> fetchDiariesByUid(String uid) async {
    // final query = _db.collection('users').doc(uid).collection('diaries');
    // return query.get();
    String url = '$_apiBaseUrl/fetch-user-diaries';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'uid': uid,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch diaries');
    }
    // JSON 배열을 List<Map<String, dynamic>> 타입으로 명시적으로 변환
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => item as Map<String, dynamic>).toList();
  }

  Future<String> getImageUrl(String url) async {
    return await _storage.ref().child(url).getDownloadURL();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchDiariesByUserAndDateRange({
    required String uid,
    required DateTime start,
    required DateTime end,
  }) {
    // 사용자의 uid와 시작일과 끝일을 받아서 해당 기간에 해당하는 일기들을 가져옴
    // startDate는 그 날의 00:00:00, endDate는 그 다음날의 00:00:00
    final startDate = DateTime(start.year, start.month, start.day);
    final endDate = DateTime(end.year, end.month, end.day + 1); // 다음날 00:00:00

    final query = _db
        .collection('users')
        .doc(uid)
        .collection('diaries')
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThan: endDate);
    return query.get();
  }
}

final diaryRepo = Provider((ref) => DiaryRepository());
