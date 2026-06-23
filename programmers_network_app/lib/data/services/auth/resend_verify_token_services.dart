import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/data/models/auth/resend_verify_token_model.dart';

class ResendVerifyTokenServices {
  final Uri resendVerifyTokenUrl = Uri.parse(
    ApiConstants.baseurl + ApiConstants.resendtoken,
  );
  Future<ResendVerifyTokenModel> resendToken({required String email}) async {
    try {
      final response = await http.post(
        resendVerifyTokenUrl,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email}),
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return ResendVerifyTokenModel.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Resend token failed');
    } catch (e) {
      throw Exception('Resend Token error: $e');
    }
  }
}
