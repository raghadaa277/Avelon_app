import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:programmers_network_app/core/const/api_constants.dart';
import 'package:programmers_network_app/data/models/auth/login_model.dart';
import 'package:programmers_network_app/core/helper/device_helper.dart';

class LoginException implements Exception {
  final int statusCode;
  final String message;
  const LoginException({required this.statusCode, required this.message});
}

class LoginServices {
  final loginUrl = Uri.parse(ApiConstants.baseurl + ApiConstants.login);

  Future<LoginModel> login({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    try {
      final deviceData = await DeviceHelper.getDeviceData();
      final request = LoginRequest(
        email: email,
        password: password,
        deviceId: deviceData["device_id"]!,
        device: deviceData["device"]!,
        fcmToken: fcmToken,
      );

      debugPrint("📤 REQUEST:");
      debugPrint(jsonEncode(request.toJson()));

      final response = await http.post(
        loginUrl,
        body: jsonEncode(request.toJson()),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      final decoded = jsonDecode(utf8.decode(response.bodyBytes));

      debugPrint("📥 DECODED RESPONSE:");
      debugPrint(decoded?.toString());

      if (decoded == null) {
        throw LoginException(
          statusCode: response.statusCode,
          message: 'Empty response from server',
        );
      }

      final backendMsg = (decoded is Map && decoded['message'] != null)
          ? decoded['message'].toString()
          : 'Unknown error';

      switch (response.statusCode) {
        case 200:
          if (decoded is Map<String, dynamic>) {
            return LoginModel.fromJson(decoded);
          }
          throw LoginException(
            statusCode: 200,
            message: 'Unexpected response format',
          );

        case 401:
          throw LoginException(statusCode: 401, message: backendMsg);

        case 403:
          throw LoginException(statusCode: 403, message: backendMsg);

        case 428:
          throw LoginException(statusCode: 428, message: backendMsg);

        case 429:
          throw LoginException(statusCode: 429, message: backendMsg);

        case 500:
          throw LoginException(statusCode: 500, message: backendMsg);

        default:
          throw LoginException(
            statusCode: response.statusCode,
            message: backendMsg,
          );
      }
    } catch (e) {
      debugPrint("❌ SERVICE ERROR:");
      debugPrint(e.toString());
      if (e is LoginException) rethrow;
      throw LoginException(statusCode: 0, message: e.toString());
    }
  }
}
