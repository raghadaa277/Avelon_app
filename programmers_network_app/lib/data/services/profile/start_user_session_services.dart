import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/core/storage/token_storage.dart';
import 'package:programmers_network_app/data/models/Profile/start_user_session_model.dart';

class UserSessionServices {
  final ApiClient startsessionApi = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<StartUserModel?> startSession() async {
    final token = await TokenStorage.getToken();

    if (token == null) {
      await TokenStorage.clearTokens();
      return null;
    }

    try {
      final response = await startsessionApi.post(
        ApiConstants.startUserSession,
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return StartUserModel.fromJson(decoded);
      }

      throw Exception(decoded['message'] ?? 'start session failed');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
