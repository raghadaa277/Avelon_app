import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/record_profile_view_model.dart';

class ProfileViewServices {
  final ApiClient apiClient = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<RecordProfileViewModel> recordProfileVeiw({
    required int targetUserId,
  }) async {
    try {
      final response = await apiClient.post(
        "${ApiConstants.recordProfileView}/$targetUserId",
      );
      final decodedResopnse = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return RecordProfileViewModel.fromJson(decodedResopnse);
      }
      throw Exception(
        decodedResopnse['message'] ?? 'Failed to get other user profile',
      );
    } catch (e) {
      rethrow;
    }
  }
}
