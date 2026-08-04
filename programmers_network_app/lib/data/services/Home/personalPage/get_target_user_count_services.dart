import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/get_other_user_profile_model.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/get_target_user_count_model.dart';

class GetTargetUserCountServices {
  final ApiClient api = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<GetTargetUserCountModel> getTargetUserCount({
    int? targetUserId,
  }) async {
    try {
      final response = await api.get(
        "${ApiConstants.getTargetUserCount}/$targetUserId",
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return GetTargetUserCountModel.fromJson(decodedResponse);
      }
      throw Exception(
        decodedResponse['message'] ?? 'Failed to get target user count',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<GetOtherUserProfileModel> getOtherUserProfile({
    int? targetUserId,
  }) async {
    try {
      final response = await api.get(
        "${ApiConstants.getOtherUserProfile}/$targetUserId",
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return GetOtherUserProfileModel.fromJson(decodedResponse);
      }
      throw Exception(
        decodedResponse['message'] ?? 'Failed to get other user profile',
      );
    } catch (e) {
      rethrow;
    }
  }
}
