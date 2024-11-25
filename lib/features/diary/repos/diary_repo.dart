import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodiary/features/diary/models/diary_model.dart';

class DiaryRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Dio _dio = Dio();
  final String _apiBaseUrl = '${dotenv.env['API_BASE_URL']}/diary';

  Future<List<String>> uploadImages({
    required String uid,
    required List<File> images,
  }) async {
    List<String> imageUrls = [];
    String baseUrl = 'users/$uid/images';
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
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to fetch diaries: $e');
      }
    }
  }

  Future<Map<String, dynamic>?> fetchDiaryByDate(
      String uid, DateTime date) async {
    String url = '$_apiBaseUrl/fetch-diary-by-date';
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
      if (response.data["status"] == "error") {
        return null;
      }
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch diary: $e');
    }
  }

  Future<String> getImageUrl(String url) async {
    return await _storage.ref().child(url).getDownloadURL();
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

  Future<Map<String, dynamic>> analizeDiary(
      String uid, DiaryModel diary) async {
    String url = '${dotenv.env['API_BASE_URL']}/analysis/analyze-diary';
    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            'uid': uid,
          },
        ),
        data: {
          'diary': diary.diaryId,
          'content': diary.content,
        },
      );
      log('analizeDiary response: $response');
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return {};
      } else {
        throw Exception('Failed to analize diary: $e');
      }
    }
  }
}

final diaryRepo = Provider((ref) => DiaryRepository());
