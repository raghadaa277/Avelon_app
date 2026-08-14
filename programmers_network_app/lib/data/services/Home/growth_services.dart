import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/helper/growth.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/growth/get_growth_model.dart';
import 'package:programmers_network_app/data/models/Home/growth/get_overview_model.dart';
import 'package:programmers_network_app/data/models/Home/growth/get_overview_post_model.dart';
import 'package:programmers_network_app/data/models/Home/growth/get_post_audience_model.dart';
import 'package:programmers_network_app/data/models/Home/growth/get_post_view_source_model.dart';

class GrowthServices {
  final ApiClient apiClient = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<GrowthResponse> getGrowth({required GrowthPeriod period}) async {
    try {
      final response = await apiClient.get(
        "${ApiConstants.getGrowth}?type=${period.value}",
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return GrowthResponse.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to get growth');
    } catch (e) {
      rethrow;
    }
  }

  Future<GetOverviewModel> getOverview({
    required String type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      if ((startDate == null) != (endDate == null)) {
        throw Exception(
          'startDate and endDate must both be provided or both be null',
        );
      }

      String url = "${ApiConstants.getOvervview}?type=$type";

      if (startDate != null && endDate != null) {
        url +=
            "&start_date=${startDate.toIso8601String()}"
            "&end_date=${endDate.toIso8601String()}";
      }

      final response = await apiClient.get(url);

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return GetOverviewModel.fromJson(decodedResponse);
      }

      throw Exception(decodedResponse['message'] ?? 'Failed to get overview');
    } catch (e) {
      rethrow;
    }
  }

  Future<GetOverviewPostModel> getOverviewPost({required int postId}) async {
    try {
      final response = await apiClient.get(
        "${ApiConstants.getOverviewPost}/$postId",
      );

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return GetOverviewPostModel.fromJson(decodedResponse);
      }

      throw Exception(
        decodedResponse['message'] ?? 'Failed to get overview post',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<GetPostAudienceResponseModel> getPostAudience({
    required int postId,
  }) async {
    try {
      final response = await apiClient.get(
        "${ApiConstants.getPostAudience}/$postId",
      );

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return GetPostAudienceResponseModel.fromJson(decodedResponse);
      }

      throw Exception(
        decodedResponse['message'] ?? 'Failed to get post audience',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<PostViewsOverviewResponseModel> getPostViewsOverview({
    required int postId,
  }) async {
    try {
      final response = await apiClient.get(
        "${ApiConstants.getPostVeiwSource}/$postId",
      );

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return PostViewsOverviewResponseModel.fromJson(decodedResponse);
      }

      throw Exception(
        decodedResponse['message'] ?? 'Failed to get post views overview',
      );
    } catch (e) {
      rethrow;
    }
  }
}
