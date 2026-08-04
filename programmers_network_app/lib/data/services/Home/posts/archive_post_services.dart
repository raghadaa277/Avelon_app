import 'dart:convert';
import 'package:programmers_network_app/core/const/api_constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/posts/archive_post_model.dart';
import 'package:programmers_network_app/data/models/Home/posts/force_delete_post_model.dart';
import 'package:programmers_network_app/data/models/Home/posts/get_archived_posts_model.dart';
import 'package:programmers_network_app/data/models/Home/posts/restor_post_model.dart';

class ArchivePostServices {
  final ApiClient archiveApi = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<ArchivePostModel> archivePost({int postNumber = 0}) async {
    try {
      final response = await archiveApi.post(
        "${ApiConstants.archivePost}/$postNumber",
      );
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ArchivePostModel.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to archive post');
    } catch (e) {
      throw Exception('Archive post error: $e');
    }
  }

  Future<GetArchivedPostsModel> getArchivedPost({int page = 1}) async {
    try {
      final response = await archiveApi.get(
        "${ApiConstants.getArchivedPosts}?posts_page=$page",
      );
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && decodedResponse['success'] == true) {
        return GetArchivedPostsModel.fromJson(decodedResponse);
      }
      throw Exception(
        decodedResponse['message'] ?? 'Failed to view archived posts',
      );
    } catch (e) {
      throw Exception('Get archived posts error: $e');
    }
  }

  Future<RestorePostModel> restore({int postNumber = 0}) async {
    try {
      final response = await archiveApi.post(
        "${ApiConstants.restorePost}/$postNumber",
      );

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return RestorePostModel.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to restore post');
    } catch (e) {
      throw Exception('Restore post error: $e');
    }
  }

  Future<ForceDeletePostModel> forceDelete({int postNumber = 1}) async {
    try {
      final response = await archiveApi.post(
        "${ApiConstants.forceDeletePost}/$postNumber",
      );
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ForceDeletePostModel.fromJson(decodedResponse);
      }
      throw Exception(
        decodedResponse['message'] ?? 'Failed to force delete post',
      );
    } catch (e) {
      throw Exception('Force delete post error: $e');
    }
  }
}
