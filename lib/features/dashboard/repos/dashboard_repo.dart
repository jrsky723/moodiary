import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardRepository {
  final Dio _dio = Dio();
  final String _apiBaseUrl = '${dotenv.env['API_BASE_URL']}/dashboard';

  Future<List<Map<String, dynamic>>> fetchOffsetList({
    required String uid,
    required DateTime start,
    required DateTime end,
  }) async {
    String url = '$_apiBaseUrl/fetch-offset-list';
    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            'uid': uid,
          },
        ),
        data: {
          'start': start.toIso8601String(),
          'end': end.toIso8601String(),
        },
      );

      List<dynamic> data = response.data;
      return data.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (e) {
      throw Exception('Failed to fetch offset list: $e');
    }
  }
}

final dashboardRepo = Provider((ref) => DashboardRepository());
