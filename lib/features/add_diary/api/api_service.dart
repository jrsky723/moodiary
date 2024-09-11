import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:moodiary/features/add_diary/models/add_diary_model.dart';

class ApiService {
  final String x_api_key = dotenv.env['X_API_KEY']!;
  final String baseURL = dotenv.env['BASE_URL']!;
  final Dio dio = Dio();

  void addJsonFieldToFormData(
      FormData formData, String fieldName, String fieldValue) {
    formData.files.add(
      MapEntry(
        fieldName,
        MultipartFile.fromString(
          fieldValue,
          contentType: MediaType('application', 'json'),
        ),
      ),
    );
  }

  Future<void> postDiary(AddDiaryModel model) async {
    try {
      final url = '$baseURL/add-diary';
      final headers = {
        "x-api-key": x_api_key,
      };
      final body = model.toJson();

      FormData formData = FormData();

      addJsonFieldToFormData(
          formData, 'author_id', body['author_id'].toString());
      addJsonFieldToFormData(formData, 'content', body['content'].toString());
      addJsonFieldToFormData(
          formData, 'is_public', body['is_public'].toString());

      for (int i = 0; i < model.photos.length; i++) {
        final filePath = model.photos[i].path;

        final mimeType = lookupMimeType(filePath);
        final mimeTypeData = mimeType!.split('/');

        formData.files.add(
          MapEntry(
            'photos',
            await MultipartFile.fromFile(
              filePath,
              contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
            ),
          ),
        );
      }

      final response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        log('Post success');
      } else {
        log('Error: ${response.statusCode}');
        log('Response data: ${response.data}');
      }
    } catch (e) {
      print(e);
    }
  }
}
