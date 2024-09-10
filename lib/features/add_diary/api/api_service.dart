import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:moodiary/features/add_diary/models/add_diary_model.dart';

class ApiService {
  final String x_api_key = dotenv.env['X_API_KEY']!;
  final String baseURL = dotenv.env['BASE_URL']!;

  Future<void> postDiary(AddDiaryModel model) async {
    final url = Uri.parse('$baseURL/add-diary');
    final headers = {
      "Content-Type": "application/json",
      "x-api-key": x_api_key,
    };
    final body = model.toJson();
    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print('post success');
      } else {
        print('post fail');
      }
    } catch (e) {
      print(e);
    }
  }
}
