import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/closeFriends/get_my_close_friends_model.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/closeFriends/toggle_close_friend_model.dart';

class CloseFriendServices {
  final ApiClient apiClient = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<ToggleCloseFriendModel> toggleCloseFriends({
    required int targetUserId,
  }) async {
    try {
      final response = await apiClient.post(
        "${ApiConstants.toggleCloseFriend}/$targetUserId",
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return ToggleCloseFriendModel.fromJson(decodedResponse);
      }
      throw Exception(
        decodedResponse['message'] ?? 'Failed to toggle close frien',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<GetCloseFriendsModel> getCloseFriends() async {
    try {
      final response = await apiClient.get(ApiConstants.getMyCloseFriends);
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return GetCloseFriendsModel.fromJson(decodedResponse);
      }
      throw Exception(
        decodedResponse['message'] ?? 'Failed to get my close friends',
      );
    } catch (e) {
      rethrow;
    }
  }
}
