import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:programmers_network_app/core/const/api_constants.dart';
import 'package:programmers_network_app/core/storage/token_storage.dart';

import 'dart:async';

import 'package:programmers_network_app/data/models/auth/refresh_token_model.dart';

class RefreshTokenService {
  static Completer<bool>? _refreshCompleter;

  final Uri refreshUrl = Uri.parse(
    ApiConstants.baseurl + ApiConstants.refreshToken,
  );
  Future<bool> refreshToken() async {
    print("========== REFRESH ==========");

    if (_refreshCompleter != null) {
      print("⏳ Waiting for another refresh...");
      return _refreshCompleter!.future;
    }

    _refreshCompleter = Completer<bool>();

    try {
      final refreshToken = await TokenStorage.getRefreshToken();
      final deviceId = await TokenStorage.getDeviceId();

      print("Stored Refresh Token: $refreshToken");
      print("Stored Device ID: $deviceId");

      if (refreshToken == null || refreshToken.isEmpty) {
        print("❌ Refresh token is null");
        _refreshCompleter!.complete(false);
        return false;
      }

      final response = await http.post(
        refreshUrl,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "refresh_token": refreshToken,
          'device_id': deviceId ?? "",
        }),
      );

      print("Refresh Status Code: ${response.statusCode}");
      print("Refresh Response: ${response.body}");

      if (response.statusCode != 200 && response.statusCode != 201) {
        print("❌ Refresh request failed");
        _refreshCompleter!.complete(false);
        return false;
      }

      final decoded = jsonDecode(utf8.decode(response.bodyBytes));

      final result = RefreshTokenModel.fromJson(decoded);

      await TokenStorage.saveTokens(
        accessToken: result.data.accessToken,
        refreshToken: result.data.refreshToken,
      );

      print("✅ New Access Token: ${result.data.accessToken}");
      print("✅ New Refresh Token: ${result.data.refreshToken}");

      _refreshCompleter!.complete(true);
      return true;
    } catch (e, s) {
      print("❌ Refresh Exception: $e");
      print(s);

      if (!(_refreshCompleter?.isCompleted ?? true)) {
        _refreshCompleter!.complete(false);
      }

      return false;
    } finally {
      _refreshCompleter = null;
    }
  }
}
