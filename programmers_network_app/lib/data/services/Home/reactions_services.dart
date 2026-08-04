import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/get_reactions_post_model.dart';
import 'package:programmers_network_app/data/models/Home/reactions_post_model.dart';

class ReactionsServices {
  final ApiClient api = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<ReactionsPostModel> reactions({
    int? targetUserId,
    int? postId,
    String? type,
  }) async {
    try {
      final response = await api.post(
        '${ApiConstants.postReactions}/$targetUserId/$postId/$type',
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return ReactionsPostModel.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to reaction');
    } catch (e) {
      rethrow;
    }
  }

  Future<ReactionsModel> getReations({
    int? targetUserId,
    int? postId,
    String? type,
    int page = 1,
  }) async {
    try {
      final response = await api.get(
        '${ApiConstants.getPostReactions}/$targetUserId/$postId/$type?page=$page',
      );
      print(response);
      final decodeResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return ReactionsModel.fromJson(decodeResponse);
      } else if (response.statusCode == 403) {
        throw Exception('Count is hidden by post author');
      }
      throw Exception(decodeResponse['message'] ?? 'Failed to get reactions');
    } catch (e) {
      rethrow;
    }
  }
}
