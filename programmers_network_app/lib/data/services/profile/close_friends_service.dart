import 'dart:convert';
import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/core/storage/token_storage.dart';
import '../../models/Profile/close_friend_model.dart';

class CloseFriendsService {
  final ApiClient closeFriendsApi = ApiClient(baseUrl: ApiConstants.baseurl);


  Future<bool> toggleCloseFriend(int userId) async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      await TokenStorage.clearTokens();
      return false;
    }

    try {
      final response = await closeFriendsApi.post(
        "${ApiConstants.toggleCloseFriend}$userId",
        body: {},
      );

      print("📡 TOGGLE CLOSE FRIEND STATUS => ${response.statusCode}");
      print("📡 TOGGLE CLOSE FRIEND BODY => ${response.body}");

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return decodedResponse['success'] == true;
      } else {
        throw Exception(
          decodedResponse['message'] ?? 'Failed to toggle close friend',
        );
      }
    } catch (e) {
      print("❌ Exception in toggleCloseFriend: $e");
      throw Exception(e.toString());
    }
  }


  Future<List<CloseFriendModel>> getCloseFriends() async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      await TokenStorage.clearTokens();
      return [];
    }

    try {
      final response = await closeFriendsApi.get(ApiConstants.getCloseFriends);

      print("📡 GET CLOSE FRIENDS STATUS => ${response.statusCode}");
      print("📡 GET CLOSE FRIENDS BODY => ${response.body}");

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && decodedResponse['success'] == true) {
        // فك التغليف بحسب استجابة الـ Pagination: data -> data
        final List listData = decodedResponse['data']['data'] ?? [];
        return listData.map((item) => CloseFriendModel.fromJson(item)).toList();
      } else {
        throw Exception(
          decodedResponse['message'] ?? 'Failed to fetch close friends',
        );
      }
    } catch (e) {
      print("❌ Exception in getCloseFriends: $e");
      throw Exception(e.toString());
    }
  }
  /// جلب سجل الأصدقاء المقربين مع دعم الـ Pagination
  Future<Map<String, dynamic>> getCloseFriendsHistory({int page = 1}) async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      await TokenStorage.clearTokens();
      return {'items': <CloseFriendModel>[], 'lastPage': 1};
    }

    try {

      final response = await closeFriendsApi.get(
        "${ApiConstants.getCloseFriendsHistory}?page=$page",
      );

      print("📡 GET HISTORY STATUS => ${response.statusCode}");
      print("📡 GET HISTORY BODY => ${response.body}");

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && decodedResponse['success'] == true) {
        final Map<String, dynamic> paginationData = decodedResponse['data'] ?? {};
        final List listData = paginationData['data'] ?? [];

        final List<CloseFriendModel> items =
        listData.map((item) => CloseFriendModel.fromJson(item)).toList();

        return {
          'items': items,
          'lastPage': paginationData['last_page'] ?? 1,
        };
      } else {
        throw Exception(decodedResponse['message'] ?? 'Failed to fetch history');
      }
    } catch (e) {
      print("❌ Exception in getCloseFriendsHistory: $e");
      throw Exception(e.toString());
    }
  }


}