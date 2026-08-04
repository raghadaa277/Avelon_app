import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/follower/get_follows_model.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/follower/toggle_following_model.dart';

class FolloweServices {
  final ApiClient apiClient = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<ToggleFollowingModel> toggleFollowing({
    required int targetUserId,
  }) async {
    try {
      final response = await apiClient.post(
        "${ApiConstants.toggleFollowing}/$targetUserId",
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return ToggleFollowingModel.fromJson(decodedResponse);
      }
      throw Exception(
        decodedResponse['message'] ?? 'Failed to get other user profile',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<FollowersModel> getFollowers({
    required int targetUserId,
    required String type,
    int page = 1,
  }) async {
    try {
      final response = await apiClient.get(
        "${ApiConstants.getFollows}/$targetUserId/follow-list/$type?page=$page",
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return FollowersModel.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to get followers');
    } catch (e) {
      rethrow;
    }
  }
}
