import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/get_time_line_model.dart';

class GetTimeLineService {
  final ApiClient apiClient = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<GetTimeLineModel> getTimeLine() async {
    try {
      final response = await apiClient.get(ApiConstants.getTimeLine);
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return GetTimeLineModel.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to get time line');
    } catch (e) {
      rethrow;
    }
  }
}
