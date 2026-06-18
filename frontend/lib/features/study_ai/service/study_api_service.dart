import '../../../core/network/api_client.dart';
import '../model/study_model.dart';

class StudyApiService {

  Future<StudyModel> askQuestion({
    required String topic,
    required String question,
  }) async {

    try {

      final response = await ApiClient.dio.post(
        "/study/ask",
        data: {
          "topic": topic,
          "question": question,
        },
      );

      return StudyModel.fromJson(response.data);

    } catch (e) {
      throw Exception("API Error: $e");
    }
  }
}