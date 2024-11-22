import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityPostRepo {
  final Dio _dio = Dio();
  final String _apiBaseUrl = '${dotenv.env['API_BASE_URL']}/community';

  Future<List<Map<String, dynamic>>> fetchRelatedPosts(
    DateTime? lastItemCreatedAt,
    String uid,
  ) async {
    String url = '$_apiBaseUrl/fetch-related-posts';
    try {
      final response = await _dio.get(
        url,
        queryParameters: {
          'lastDate': lastItemCreatedAt?.toIso8601String(),
          'size': 5,
        },
        options: Options(
          headers: {
            'uid': uid,
          },
        ),
      );
      final List<dynamic> data = response.data;
      return data.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (e) {
      throw Exception('Failed to fetch related posts: $e');
    }
  }
}

final communityPostRepo = Provider((ref) => CommunityPostRepo());
