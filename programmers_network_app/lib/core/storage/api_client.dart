import 'dart:convert';
import 'dart:io';

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
          http.get(Uri.parse("$baseUrl$endpoint"), headers: await _headers()),
    );
  }

  Future<http.Response> post(String endpoint, {dynamic body}) async {
    return _sendRequest(
      () async => http.post(
        Uri.parse("$baseUrl$endpoint"),
        headers: await _headers(),
        body: jsonEncode(body),
      ),
    );
  }

  Future<http.Response> put(String endpoint, {dynamic body}) async {
    return _sendRequest(
      () async => http.put(
        Uri.parse("$baseUrl$endpoint"),
        headers: await _headers(),
        body: jsonEncode(body),
      ),
    );
  }

  Future<http.Response> patch(String endpoint, {dynamic body}) async {
    return _sendRequest(
      () async => http.patch(
        Uri.parse("$baseUrl$endpoint"),
        headers: await _headers(),
        body: jsonEncode(body),
      ),
    );
  }

  Future<http.Response> delete(String endpoint) async {
    return _sendRequest(
      () async => http.delete(
        Uri.parse("$baseUrl$endpoint"),
        headers: await _headers(),
      ),
    );
  }

  Future<http.Response> multipartPost({
    required String endpoint,
    required Map<String, String> fields,
    List<File>? files,
  }) async {
    Future<http.Response> sendRequest() async {
      final token = await TokenStorage.getToken();

      final request = http.MultipartRequest(
        "POST",
        Uri.parse("$baseUrl$endpoint"),
      );

      request.headers.addAll({
        "Accept": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      });

      request.fields.addAll(fields);

      if (files != null && files.isNotEmpty) {
        for (int i = 0; i < files.length; i++) {
          request.files.add(
            await http.MultipartFile.fromPath("media[$i]", files[i].path),
          );
        }
      }

      final streamedResponse = await request.send();

      return http.Response.fromStream(streamedResponse);
    }

    return _sendRequest(sendRequest);
  }

  Future<http.Response> _sendRequest(
    Future<http.Response> Function() request,
  ) async {
    var response = await request();

    print("=========== API RESPONSE ===========");
    print("Status Code: ${response.statusCode}");
    print("Body: ${response.body}");
    print("===================================");

    if (response.statusCode == 410) {
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

  Future<http.Response> postMultipart(
    String endpoint,
    File file,
    String fieldName,
  ) async {
    final token = await TokenStorage.getToken();
    final uri = Uri.parse('$baseUrl$endpoint');

    final request = http.MultipartRequest('POST', uri);

    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    request.headers['Accept'] = 'application/json';

    request.files.add(await http.MultipartFile.fromPath(fieldName, file.path));

    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }
}
