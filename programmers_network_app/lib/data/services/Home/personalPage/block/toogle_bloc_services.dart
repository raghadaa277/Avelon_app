import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/block/toogle_block_model.dart';

class ToogleBlocServices {
  final ApiClient apiClient = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<ToggleBlockModel> toggleBlock({required int targetUserId}) async {
    try {
      final response = await apiClient.post(
        "${ApiConstants.toggleBlock}/$targetUserId",
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return ToggleBlockModel.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to toggle block');
    } catch (e) {
      rethrow;
    }
  }
}
