// 데이터 유지및 데이터 가져오기만 하는 클래스

import 'package:moodiary/features/add_diary/api/api_service.dart';
import 'package:moodiary/features/add_diary/models/add_diary_model.dart';

class AddDiaryRepository {
  static final ApiService _apiService = ApiService();

  AddDiaryRepository();
  Future<void> postDiary(AddDiaryModel model) async {
    return _apiService.postDiary(model);
  }
}
