import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/mutualFollowers/get_mutual_followers_model.dart';

class GetMutualFollowersServices {
  final ApiClient apiClient = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<GetMutualFollowersModel> mutualFollowers({
    required int targetUserId,
    int page = 1,
  }) async {
    try {
      final response = await apiClient.get(
        "${ApiConstants.mutualFollowers}/$targetUserId/?page=$page",
      );
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return GetMutualFollowersModel.fromJson(decodedResponse);
      }
      throw Exception(
        decodedResponse['message'] ?? 'Failed to get mutual followers',
      );
    } catch (e) {
      rethrow;
    }
  }
}
