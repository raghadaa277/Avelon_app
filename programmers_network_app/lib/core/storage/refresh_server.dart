// import 'dart:convert';

// import 'package:flutter_dori_application/core/const/api_Constants.dart';
// import 'package:flutter_dori_application/core/storage/token_storage.dart';
// import 'package:http/http.dart' as http;

// class RefreshTokenService {
//   final Uri refreshUrl = Uri.parse(
//     ApiConstants.baseUrl + ApiConstants.refreshToken,
//   );

//   Future<bool> refreshToken() async {
//     try {
//       final refreshToken = await TokenStorage.getRefreshToken();

//       final response = await http.post(
//         refreshUrl,
//         headers: {
//           "Accept": "application/json",
//           "Content-Type": "application/json",
//         },
//         body: jsonEncode({"refresh_token": refreshToken}),
//       );

//       final decoded = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         await TokenStorage.saveTokens(
//           accessToken: decoded["data"]["access_token"],
//           refreshToken: decoded["data"]["refresh_token"],
//         );

//         return true;
//       }

//       return false;
//     } catch (_) {
//       return false;
//     }
//   }
// }
