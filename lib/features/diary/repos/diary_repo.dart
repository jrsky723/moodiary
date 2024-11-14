import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/diary/models/diary_model.dart';

class DiaryRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final Dio _dio = Dio();
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
    String url = '$_apiBaseUrl/add-diary';
    try {
      final response = await _dio.post(
        url,
        data: diary.toJson(),
        options: Options(
          headers: {
            'uid': diary.uid,
          },
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to create diary: $e');
    }
  }

  Future<void> updateDiary(
      String uid, int diaryId, Map<String, dynamic> data) async {
    String url = '$_apiBaseUrl/update-diary';
    log('updateDiary: $data');
    try {
      final response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'uid': uid,
            'diaryId': diaryId,
          },
        ),
      );
      log('updateDiary response: $response');
      return;
    } catch (e) {
      throw Exception('Failed to update diary: $e');
    }
  }

  Future<void> updateCommunityDiary(
    String diaryId,
    Map<String, dynamic> data,
  ) async {
    await _db.collection('community').doc(diaryId).update(data);
  }

  Future<void> deleteDiary(String uid, int diaryId) async {
    String url = '$_apiBaseUrl/delete-diary';
    try {
      final response = await _dio.delete(
        url,
        options: Options(
          headers: {
            'uid': uid,
            'diaryId': diaryId,
          },
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to delete diary: $e');
    }
  }

  Future<Map<String, dynamic>> fetchDiaryByUserAndId(
    String uid,
    String diaryId,
  ) async {
    String url = '$_apiBaseUrl/fetch-detail';
    try {
      final response = await _dio.get(
        url,
        queryParameters: {
          'diaryId': diaryId,
        },
        options: Options(
          headers: {
            'uid': uid,
          },
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch diary: $e');
    }
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
    String url = '$_apiBaseUrl/fetch-user-diaries';
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'uid': uid,
          },
        ),
      );
      final List<dynamic> data = response.data;
      return data.map((item) => item as Map<String, dynamic>).toList();
    } catch (e) {
      throw Exception('Failed to fetch diaries: $e');
    }
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

  Future<List<Map<String, dynamic>>> fetchDiariesByYearMonth({
    required String uid,
    required DateTime date, // year, month 정보가 있는 date
  }) async {
    String url = '$_apiBaseUrl/fetch-diaries-by-year-month';
    try {
      final response = await _dio.get(
        url,
        queryParameters: {
          'date': date.toIso8601String(),
        },
        options: Options(
          headers: {
            'uid': uid,
          },
        ),
      );
      final List<dynamic> data = response.data;

      return data.map((item) => item as Map<String, dynamic>).toList();
    } catch (e) {
      throw Exception('Failed to fetch diaries: $e');
    }
  }
}

final diaryRepo = Provider((ref) => DiaryRepository());
