import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:programmers_network_app/core/const/routesPage.dart';
import 'package:programmers_network_app/core/storage/token_storage.dart';
import 'package:programmers_network_app/data/services/Home/refresh_token_services.dart';

class ApiClient {
  final String baseUrl;

  ApiClient({required this.baseUrl});

  Future<Map<String, String>> _headers() async {
    final token = await TokenStorage.getToken();

    return {
      "Accept": "application/json",
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  Future<http.Response> get(String endpoint) async {
    return _sendRequest(
      () async =>
          http.get(Uri.parse('$baseUrl$endpoint'), headers: await _headers()),
    );
  }

  Future<http.Response> post(String endpoint, {dynamic body}) async {
    return _sendRequest(
      () async => http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: await _headers(),
        body: jsonEncode(body),
      ),
    );
  }

  Future<http.Response> put(String endpoint, {dynamic body}) async {
    return _sendRequest(
      () async => http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: await _headers(),
        body: jsonEncode(body),
      ),
    );
  }

  Future<http.Response> delete(String endpoint) async {
    return _sendRequest(
      () async => http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: await _headers(),
      ),
    );
  }

  Future<http.Response> _sendRequest(
    Future<http.Response> Function() request,
  ) async {
    var response = await request();

    if (response.statusCode == 401) {
      final refreshed = await RefreshTokenService().refreshToken();

      if (refreshed) {
        response = await request();
      } else {
        await TokenStorage.clearTokens();
        Get.offAllNamed(AppRoute.login);
      }
    }

    return response;
  }
}
