import 'dart:convert';

import 'package:programmers_network_app/core/const/api_constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';

import 'package:programmers_network_app/data/models/Home/personalPage/get_target_user_posts_model.dart';

class GetTargetUserPostServices {
  final ApiClient apiClient = ApiClient(baseUrl: ApiConstants.baseurl);
  Future<GetTargetUserPostsModel> getTargetUserPost({
    required int targetUserId,
    int page = 1,
  }) async {
    try {
      final response = await apiClient.get(
        "${ApiConstants.getTargetUserPost}/$targetUserId?page=$page",
      );
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return GetTargetUserPostsModel.fromJson(decodedResponse);
      }
      throw Exception(
        decodedResponse['message'] ?? 'Failed to get target user post',
      );
    } catch (e) {
      rethrow;
    }
  }
}
