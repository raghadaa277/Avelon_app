import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/posts/comments/create_comment_mode.dart';
import 'package:programmers_network_app/data/models/Home/posts/comments/delete_comment_model.dart';
import 'package:programmers_network_app/data/models/Home/posts/comments/edit_comment_model.dart';
import 'package:programmers_network_app/data/models/Home/posts/comments/get_post_comments_model.dart';
import 'package:programmers_network_app/data/models/Home/posts/comments/get_reactions_comment_model.dart';
import 'package:programmers_network_app/data/models/Home/posts/comments/manage_comments_model.dart';
import 'package:programmers_network_app/data/models/Home/posts/comments/reactions_comments_model.dart';
import 'package:programmers_network_app/data/models/Home/posts/comments/replies_comments_model.dart';

class CommentsServices {
  final ApiClient apiClient = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<PostCommentsResponse> getPostComment({
    int? targetUserId,
    int? postId,
    int page = 1,
  }) async {
    try {
      final response = await apiClient.get(
        "${ApiConstants.getPostComments}/$targetUserId/$postId/?page=$page",
      );

      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return PostCommentsResponse.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to get comments');
    } catch (e) {
      rethrow;
    }
  }

  Future<GetCommentRepliesResponse> getCommentReplies({
    required int targetUserId,
    required int postId,
    required int commentId,
    int page = 1,
  }) async {
    try {
      final response = await apiClient.get(
        "${ApiConstants.repliesComment}/$targetUserId/$postId/$commentId?page=$page",
      );

      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return GetCommentRepliesResponse.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to get replies');
    } catch (e) {
      rethrow;
    }
  }

  Future<CreateCommentMode> createComment({
    int? targetUserId,
    int? postId,
    int? parentId,
    String? content,
  }) async {
    try {
      final response = await apiClient.post(
        '${ApiConstants.createComment}/$targetUserId/$postId',

        body: {
          'content': content,
          // ignore: use_null_aware_elements
          if (parentId != null) 'parent_id': parentId,
        },
      );

      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return CreateCommentMode.fromJSon(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to create comment');
    } catch (e) {
      rethrow;
    }
  }

  Future<DeleteCommentModel> deleteComment({
    int? targetUserId,
    int? postId,
    int? commentId,
  }) async {
    try {
      final response = await apiClient.post(
        "${ApiConstants.deleteComment}/$targetUserId/$postId/$commentId",
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return DeleteCommentModel.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to delete comment');
    } catch (e) {
      rethrow;
    }
  }

  Future<ReactionsCommentsModel> reactionsComment({
    int? targetUserId,
    int? postId,
    int? commentId,
    String? type,
  }) async {
    try {
      final response = await apiClient.post(
        "${ApiConstants.commentReactions}/$targetUserId/$postId/$commentId/$type",
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return ReactionsCommentsModel.fromJson(decodedResponse);
      }
      throw Exception(
        decodedResponse['message'] ?? 'Failed to react to comment',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<GetReactionsCommentModel> getReations({
    int? targetUserId,
    int? postId,
    String? type,
    int? commentId,
    int page = 1,
  }) async {
    try {
      final response = await apiClient.get(
        '${ApiConstants.getCommentReactions}/$targetUserId/$postId/$commentId/$type?page=$page',
      );
      print(response);
      final decodeResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return GetReactionsCommentModel.fromJson(decodeResponse);
      } else if (response.statusCode == 403) {
        throw Exception('Count is hidden by post author');
      }
      throw Exception(decodeResponse['message'] ?? 'Failed to get reactions');
    } catch (e) {
      rethrow;
    }
  }

  Future<EditCommentModel> editComment({
    int? targetUserId,
    int? postId,
    int? commentId,
    String? content,
  }) async {
    try {
      final response = await apiClient.post(
        "${ApiConstants.editComment}/$targetUserId/$postId/$commentId",
        body: {'content': content},
      );
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return EditCommentModel.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to edit comment');
    } catch (e) {
      rethrow;
    }
  }

  Future<ManageCommentModel> manageComments({
    required int postId,
    required int commentId,
    required String action,
  }) async {
    try {
      final response = await apiClient.post(
        "${ApiConstants.manageComments}/$postId/$commentId",
        body: {'action': action},
      );
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ManageCommentModel.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Failed to manage comment');
    } catch (e) {
      rethrow;
    }
  }
}
