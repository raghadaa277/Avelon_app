// import 'dart:convert';
// import 'package:flutter_dori_application/core/storage/token_storage.dart';
// import 'package:http/http.dart' as http;

// class ApiClient {
//   final String baseUrl;
//   final TokenStorage tokenStorage;


//   ApiClient({
//     required this.baseUrl,
//     required this.tokenStorage,
    
//   });

//   Future<http.Response> get(
//     String endpoint,
//   ) async {
//     return _sendRequest(
//       () async => http.get(
//         Uri.parse('$baseUrl$endpoint'),
//         headers: await _headers(),
//       ),
//     );
//   }

//   Future<http.Response> post(
//     String endpoint, {
//     dynamic body,
//   }) async {
//     return _sendRequest(
//       () async => http.post(
//         Uri.parse('$baseUrl$endpoint'),
//         headers: await _headers(),
//         body: jsonEncode(body),
//       ),
//     );
//   }

//   Future<Map<String, String>> _headers() async {
//     return {
//       'Content-Type': 'application/json',
//       'Authorization':
//           // 'Bearer ${tokenStorage.accessToken}',
//     };
//   }

//   Future<http.Response> _sendRequest(
//     Future<http.Response> Function() request,
//   ) async {
//     var response = await request();

//     if (response.statusCode == 422) {
//       final refreshed = await _refreshToken();

//       if (refreshed) {
//         response = await request();
//       } else {
//         await tokenStorage.clear();
//         authCubit.logout();

//         throw ApiException(
//           statusCode: 401,
//           message: 'Session expired',
//         );
//       }
//     }

//     return response;
//   }

//   Future<bool> _refreshToken() async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/auth/refresh'),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'refreshToken': tokenStorage.refreshToken,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         await tokenStorage.saveTokens(
//           access: data['accessToken'],
//           refresh: data['refreshToken'],
//         );

//         return true;
//       }

//       return false;
//     } catch (_) {
//       return false;
//     }
//   }
// }