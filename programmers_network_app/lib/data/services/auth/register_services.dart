import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/data/models/auth/register_model.dart';

class RegisterServices {
  final Uri registerUrl = Uri.parse(
    ApiConstants.baseurl + ApiConstants.register,
  );

  Future<RegisterModel> register({
    required String fullName,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await http.post(
        registerUrl,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'full_name': fullName,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return RegisterModel.fromJson(decodedResponse);
      }

      throw Exception(decodedResponse['message'] ?? 'Registration failed');
    } catch (e) {
      throw Exception('Register error: $e');
    }
  }
}
