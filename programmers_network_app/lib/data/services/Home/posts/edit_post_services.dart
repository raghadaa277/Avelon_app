import 'dart:convert';
import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/posts/delete_post_media_model.dart';
import 'package:programmers_network_app/data/models/Home/posts/pinned_post_model.dart';
import 'package:programmers_network_app/data/models/Home/posts/save_post_model.dart';

class EditPostServices {
  final ApiClient api = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<PinnedPostModel> pinnedPost({int postNumber = 1}) async {
    try {
      final response = await api.post("${ApiConstants.pinnedPost}/$postNumber");

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return PinnedPostModel.fromJson(decodedResponse);
      }

      throw Exception(decodedResponse['message'] ?? 'Failed to pin post');
    } catch (e) {
      rethrow;
    }
  }

  Future<DeletePostMediaModel> deleteMedia({
    int postId = 1,
    int postMediaId = 1,
  }) async {
    try {
      final response = await api.post(
        "${ApiConstants.deletePostMedia}/$postId/$postMediaId",
      );
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return DeletePostMediaModel.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to delete post');
    } catch (e) {
      rethrow;
    }
  }

  Future<SavePostModel> savePost({int? targetUserId, int? postId}) async {
    try {
      final response = await api.post(
        '${ApiConstants.savePost}/$targetUserId/$postId',
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return SavePostModel.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to save post');
    } catch (e) {
      rethrow;
    }
  }
}
