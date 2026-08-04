import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/mute/toggle_mute_model.dart';

class MuteServices {
  final ApiClient apiClient = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<ToggleMuteModel> toggleMute({required int targetUserId}) async {
    try {
      final response = await apiClient.post(
        "${ApiConstants.toggleMute}/$targetUserId",
      );

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ToggleMuteModel.fromJson(decodedResponse);
      }

      throw Exception(
        decodedResponse['message'] ?? 'Failed to toggle mute account',
      );
    } catch (e) {
      rethrow;
    }
  }
}
