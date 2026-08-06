import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/mutualFollowers/get_connection_analysis_model.dart';

class GetConnectionAnalysisServices {
  final ApiClient apiClient = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<GetConnectionAnalysisModel> connectionAnalysis({
    required int targetUserId,
  }) async {
    try {
      final response = await apiClient.get(
        "${ApiConstants.connentionAnalysis}/$targetUserId",
      );
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return GetConnectionAnalysisModel.fromJson(decodedResponse);
      }
      throw Exception(
        decodedResponse['message'] ?? 'Failed to get connection analysis',
      );
    } catch (e) {
      rethrow;
    }
  }
}
