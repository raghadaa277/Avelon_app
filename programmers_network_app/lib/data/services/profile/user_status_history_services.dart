import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/core/storage/token_storage.dart';
import 'package:programmers_network_app/data/models/Profile/user_status_history_model.dart';

class UserStatusHistoryServices {
  final ApiClient userApi = ApiClient(baseUrl: ApiConstants.baseurl);
  Future<UserStatusHistoryModel?> getUserStatus() async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      await TokenStorage.clearTokens();
      return null;
    }
    try {
      final response = await userApi.get(ApiConstants.getUserStatusesHistory);

      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return UserStatusHistoryModel.fromJson(decodedResponse);
      }
      throw Exception(
        decodedResponse['message'] ?? 'Get user status history failed',
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
