


import 'dart:convert';

import '../../../core/const/api_Constants.dart';
import '../../../core/storage/api_client.dart';
import '../../../core/storage/token_storage.dart';
import '../../models/Profile/UserFollowModel.dart';

class FollowService {
  final ApiClient followApi = ApiClient(baseUrl: ApiConstants.baseurl);


  Future<bool> toggleFollow(int userId) async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      await TokenStorage.clearTokens();
      return false;
    }

    try {
      final response = await followApi.post(
        "${ApiConstants.toggleFollow}$userId",
        body: {},
      );

      print("📡 TOGGLE FOLLOW STATUS => ${response.statusCode}");
      print("📡 TOGGLE FOLLOW BODY => ${response.body}");

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return decodedResponse['success'] == true;
      } else {
        throw Exception(
          decodedResponse['message'] ?? 'Failed to toggle follow status',
        );
      }
    } catch (e) {
      print("❌ Exception in toggleFollow: $e");
      throw Exception(e.toString());
    }
  }


  Future<List<UserFollowModel>> getFollowers(int userId, {int page = 1}) async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      await TokenStorage.clearTokens();
      return [];
    }

    try {
      final response = await followApi.get(
        "${ApiConstants.getFollowers}$userId/follow-list/followers?page=$page",
      );

      print("📡 GET FOLLOWERS STATUS => ${response.statusCode}");
      print("📡 GET FOLLOWERS BODY => ${response.body}");

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && decodedResponse['success'] == true) {
        final List listData = decodedResponse['data']['data'] ?? [];
        return listData.map((item) => UserFollowModel.fromJson(item)).toList();
      } else {
        throw Exception(
          decodedResponse['message'] ?? 'Failed to fetch followers',
        );
      }
    } catch (e) {
      print("❌ Exception in getFollowers: $e");
      throw Exception(e.toString());
    }
  }


  Future<Map<String, dynamic>> getFollowHistory({
    required String type, // 'followers' or 'followings'
    int page = 1,
  }) async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      await TokenStorage.clearTokens();
      return {'items': <UserFollowModel>[], 'lastPage': 1};
    }

    try {

      final response = await followApi.get(
        "${ApiConstants.getFollowHistory}$type?page=$page",
      );

      print("📡 GET FOLLOW HISTORY ($type) STATUS => ${response.statusCode}");
      print("📡 GET FOLLOW HISTORY ($type) BODY => ${response.body}");

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && decodedResponse['success'] == true) {
        final Map<String, dynamic> paginationData = decodedResponse['data'] ?? {};
        final List listData = paginationData['data'] ?? [];

        final List<UserFollowModel> items =
        listData.map((item) => UserFollowModel.fromJson(item)).toList();

        return {
          'items': items,
          'lastPage': paginationData['last_page'] ?? 1,
        };
      } else {
        throw Exception(
          decodedResponse['message'] ?? 'Failed to fetch follow history',
        );
      }
    } catch (e) {
      print("❌ Exception in getFollowHistory: $e");
      throw Exception(e.toString());
    }
  }
}