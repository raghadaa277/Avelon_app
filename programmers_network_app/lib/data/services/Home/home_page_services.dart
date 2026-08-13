import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/get_feed_source_model.dart';
import 'package:programmers_network_app/data/models/Home/home_page_model.dart';
import 'package:programmers_network_app/data/models/Home/recored_feed_seen_model.dart';

class HomePageServices {
  final ApiClient apiClient = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<HomeFeedResponse> feed({int page = 1}) async {
    try {
      final response = await apiClient.get(
        '${ApiConstants.getFeed}?page=$page',
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return HomeFeedResponse.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to get home page');
    } catch (e) {
      rethrow;
    }
  }

  Future<GetFeedSourceModel> getSource({required int feedId}) async {
    try {
      final response = await apiClient.get(
        "${ApiConstants.getFeedSource}/$feedId",
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return GetFeedSourceModel.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to get source ');
    } catch (e) {
      rethrow;
    }
  }

  Future<RecordFeedSeenModel> feedSeen({required int feedId}) async {
    try {
      final response = await apiClient.post("${ApiConstants.feedSeen}/$feedId");

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return RecordFeedSeenModel.fromJson(decodedResponse);
      }

      throw Exception(
        decodedResponse['message'] ?? 'Failed to record feed seen',
      );
    } catch (e) {
      rethrow;
    }
  }
}
