import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/core/storage/token_storage.dart';
import 'package:programmers_network_app/data/models/Profile/user_sessions/end_user_session_model.dart';
import 'package:programmers_network_app/data/models/Profile/user_sessions/get_user_daily_model.dart';
import 'package:programmers_network_app/data/models/Profile/user_sessions/start_user_session_model.dart';

class UserSessionServices {
  final ApiClient usersessionApi = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<StartUserModel?> startSession() async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      await TokenStorage.clearTokens();
      return null;
    }
    try {
      final response = await usersessionApi.post(ApiConstants.startUserSession);
      final decoded = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return StartUserModel.fromJson(decoded);
      }
      throw Exception(decoded['message'] ?? 'start session failed');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<EndUserSessionModel?> endSession() async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      await TokenStorage.clearTokens();
      return null;
    }
    try {
      final response = await usersessionApi.post(ApiConstants.endUserSession);
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return EndUserSessionModel.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'end session failed');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserDailyUsageModel?> getUserDailyUsage(
    String filter, {
    String? customDate,
  }) async {
    final token = await TokenStorage.getToken();

    if (token == null) {
      await TokenStorage.clearTokens();
      return null;
    }

    try {
      final query = StringBuffer('?filter=$filter');
      if (customDate != null && customDate.isNotEmpty) {
        query.write('&custome_date=$customDate');
      }

      final response = await usersessionApi.get(
        "${ApiConstants.getuserdaily}$query",
      );
      print("Refresh Status: ${response.statusCode}");
      print("Refresh Body: ${response.body}");

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return UserDailyUsageModel.fromJson(decodedResponse);
      }

      throw Exception(
        decodedResponse['message'] ?? 'Get user daily usage failed',
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
