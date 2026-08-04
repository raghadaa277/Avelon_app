import 'dart:convert';

import 'package:programmers_network_app/core/const/api_constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/posts/tage_post_model.dart';

class TagePostServices {
  final ApiClient api = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<TagePostModel> getTage() async {
    try {
      final response = await api.get(ApiConstants.tagePost);
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return TagePostModel.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to get tags post');
    } catch (e) {
      rethrow;
    }
  }
}
