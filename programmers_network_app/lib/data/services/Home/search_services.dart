import 'dart:convert';

import 'package:programmers_network_app/core/const/api_constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/search_model.dart';
import 'package:programmers_network_app/data/models/Home/search_post_model.dart';

class SearchServices {
  final ApiClient api = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<SearchResponseModel> search({
    String? user,
    String? search,
    int page = 1,
  }) async {
    try {
      final response = await api.get(
        "${ApiConstants.search}?type=$user&search=$search&page=$page",
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return SearchResponseModel.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to search');
    } catch (e) {
      rethrow;
    }
  }

  Future<PostSearchResponse> getPostSearch({
    String? type,
    String? search,
    int page = 1,
  }) async {
    try {
      final response = await api.get(
        "${ApiConstants.searchPost}?type=$type&search=$search&page=$page",
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return PostSearchResponse.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to search');
    } catch (e) {
      rethrow;
    }
  }
}
