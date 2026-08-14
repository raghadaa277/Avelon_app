import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/question/create_question_model.dart';

class QuestionsServices {
  final ApiClient apiClient = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<CreateQuestionModel> createQuestion({
    required int targetUserId,
    required String type,
    required String question,
    required String title,
  }) async {
    try {
      final response = await apiClient.post(
        "${ApiConstants.createQustions}/$targetUserId",
        body: {'type': type, 'question': question, 'title': title},
      );

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return CreateQuestionModel.fromJson(decodedResponse);
      }

      throw Exception(
        decodedResponse['message'] ?? 'Failed to create question',
      );
    } catch (e) {
      rethrow;
    }
  }
}
