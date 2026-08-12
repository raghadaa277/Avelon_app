import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/get_target_user_skills_model.dart';

class GetTargetUserSkillsServices {
  final ApiClient apiClient = ApiClient(baseUrl: ApiConstants.baseurl);
  Future<GetUserSkillsModel> getSkills({required int targetUserId}) async {
    print('🔵 Calling getSkills API for user: $targetUserId');
    try {
      final response = await apiClient.get(
        "${ApiConstants.getTargetUserSkills}/$targetUserId",
      );
      print('🟢 Response status: ${response.statusCode}');
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return GetUserSkillsModel.fromJson(decodedResponse);
      }
      throw Exception(
        decodedResponse['message'] ?? 'Failed to get user skills',
      );
    } catch (e) {
      rethrow;
    }
  }
}
