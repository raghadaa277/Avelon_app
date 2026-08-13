import 'dart:convert';

import 'package:programmers_network_app/core/const/api_constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/get_activities_model.dart';

class GetActivitesServices {
  final ApiClient api = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<GetActivitesResponse> getActivites({
    required String type,
    int page = 1,
  }) async {
    try {
      final response = await api.get(
        "${ApiConstants.getActivities}/$type?page=$page",
      );

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return GetActivitesResponse.fromJson(decodedResponse);
      }

      throw Exception(decodedResponse['message'] ?? 'Failed to get activities');
    } catch (e) {
      rethrow;
    }
  }
}
