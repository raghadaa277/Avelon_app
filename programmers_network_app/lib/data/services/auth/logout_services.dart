import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/helper/device_helper.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/core/storage/token_storage.dart';
import 'package:programmers_network_app/data/models/auth/logout_model.dart';

class LogoutServices {
  final ApiClient api = ApiClient(baseUrl: ApiConstants.baseurl);
  Future<LogoutModel?> logout() async {
    final token = await TokenStorage.getToken();

    if (token == null) {
      await TokenStorage.clearTokens();
      return null;
    }

    final refreshToken = await TokenStorage.getRefreshToken();
    final deviceData = await DeviceHelper.getDeviceData();

    final response = await api.post(
      ApiConstants.logout,
      body: {
        "refresh_token": refreshToken,
        "device_id": deviceData["device_id"],
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await TokenStorage.clearTokens();
      return LogoutModel.fromJson(data);
    }

    return null;
  }
}
