import 'dart:convert';
import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/core/storage/token_storage.dart';
import '../../models/Profile/muted_user_model.dart'; // تأكد من المسار الصحيح للموديل

class MutedUsersService {
  final ApiClient mutedUsersApi = ApiClient(baseUrl: ApiConstants.baseurl);

  /// 1. التبديل بين الكتم وإلغاء الكتم (Toggle Mute/Unmute)
  Future<bool> toggleMuteUser(int userId) async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      await TokenStorage.clearTokens();
      return false;
    }

    try {
      final response = await mutedUsersApi.post(
        "${ApiConstants.toggleMuteUser}$userId",
        body: {},
      );

      print("📡 TOGGLE MUTE STATUS => ${response.statusCode}");
      print("📡 TOGGLE MUTE BODY => ${response.body}");

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return decodedResponse['success'] == true;
      } else {
        throw Exception(
          decodedResponse['message'] ?? 'Failed to toggle mute status',
        );
      }
    } catch (e) {
      print("❌ Exception in toggleMuteUser: $e");
      throw Exception(e.toString());
    }
  }

  /// 2. جلب قائمة المستخدمين المكتومين (Muted Users)
  Future<List<MutedUserModel>> getMutedUsers() async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      await TokenStorage.clearTokens();
      return [];
    }

    try {
      final response = await mutedUsersApi.get(ApiConstants.getMutedUsers);

      print("📡 GET MUTED USERS STATUS => ${response.statusCode}");
      print("📡 GET MUTED USERS BODY => ${response.body}");

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && decodedResponse['success'] == true) {
        final List listData = decodedResponse['data']['data'] ?? [];
        return listData.map((item) => MutedUserModel.fromJson(item)).toList();
      } else {
        throw Exception(
          decodedResponse['message'] ?? 'Failed to fetch muted users',
        );
      }
    } catch (e) {
      print("❌ Exception in getMutedUsers: $e");
      throw Exception(e.toString());
    }
  }

  /// 3. جلب سجل الحظر/الكتم (History) مع دعم Pagination وتحديد النوع (sent / received)
  Future<Map<String, dynamic>> getMutedUserHistory({
    required String type,
    int page = 1,
  }) async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      await TokenStorage.clearTokens();
      return {'items': <MutedUserModel>[], 'lastPage': 1};
    }

    try {
      // تحديد الـ Endpoint بناءً على النوع (sent = my / received = by)
      final String endpoint = type == 'sent'
          ? ApiConstants.getMutedUserHistoryMy
          : ApiConstants.getMutedUserHistoryBy;

      final response = await mutedUsersApi.get("$endpoint?page=$page");

      print("📡 GET MUTED HISTORY STATUS => ${response.statusCode}");
      print("📡 GET MUTED HISTORY BODY => ${response.body}");

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && decodedResponse['success'] == true) {
        final Map<String, dynamic> paginationData = decodedResponse['data'] ?? {};
        final List listData = paginationData['data'] ?? [];

        final List<MutedUserModel> items =
        listData.map((item) => MutedUserModel.fromJson(item)).toList();

        return {
          'items': items,
          'lastPage': paginationData['last_page'] ?? 1,
        };
      } else {
        throw Exception(
          decodedResponse['message'] ?? 'Failed to fetch muted history',
        );
      }
    } catch (e) {
      print("❌ Exception in getMutedUserHistory: $e");
      throw Exception(e.toString());
    }
  }
}