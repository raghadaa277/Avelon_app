import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:programmers_network_app/core/const/api_constants.dart';
import 'package:programmers_network_app/data/models/auth/forget_password_model.dart';

class ForgetException implements Exception {
  final int statusCode;
  final String message;
  const ForgetException({required this.statusCode, required this.message});
}

class ForgetPasswordServices {
  final Uri forgetPasswordUrl = Uri.parse(
    ApiConstants.baseurl + ApiConstants.forgetPassword,
  );

  Future<ForgetPasswordModel> forget({required String email}) async {
    try {
      final response = await http.post(
        forgetPasswordUrl,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({'email': email}),
      );
      final decodedResponse = jsonDecode(response.body);
      final backendMsg =
          (decodedResponse is Map && decodedResponse['message'] != null)
          ? decodedResponse['message'].toString()
          : 'Unknown error';

      switch (response.statusCode) {
        case 201:
          if (decodedResponse is Map<String, dynamic>) {
            return ForgetPasswordModel.fromJson(decodedResponse);
          }
          throw ForgetException(
            statusCode: 201,
            message: 'Unexpected response format',
          );

        case 403:
          throw ForgetException(statusCode: 403, message: backendMsg);

        case 404:
          throw ForgetException(statusCode: 404, message: backendMsg);

        case 429:
          throw ForgetException(statusCode: 429, message: backendMsg);

        case 500:
          throw ForgetException(statusCode: 500, message: backendMsg);

        default:
          throw ForgetException(
            statusCode: response.statusCode,
            message: backendMsg,
          );
      }
    } catch (e) {
      debugPrint("❌ SERVICE ERROR:");
      debugPrint(e.toString());
      if (e is ForgetException) rethrow;
      throw ForgetException(statusCode: 0, message: e.toString());
    }
  }
}
