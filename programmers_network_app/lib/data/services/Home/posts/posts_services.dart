import 'dart:convert';
import 'dart:io';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/posts/create_post_model.dart';
import 'package:programmers_network_app/data/models/Home/posts/get_my_posts_model.dart';

class PostsServices {
  final ApiClient api = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<CreatePostModel> createPost({
    required String type,
    required String title,
    required String content,
    required String visibility,
    required bool allowComments,
    required bool hideCommentsCount,
    required bool hideReactions,
    required bool hideReactionsCount,
    required bool hideViews,
    required bool hideViewsCount,
    String? publishedAt,
    List<File>? media,

    String? pollQuestion,
    List<String>? pollOptions,
    bool? allowMultipleAnswers,
  }) async {
    try {
      final Map<String, String> fields = {
        "type": type,
        "visibility": visibility,
        "allow_comments": allowComments ? "1" : "0",
        "hide_comments_count": hideCommentsCount ? "1" : "0",
        "hide_reactions": hideReactions ? "1" : "0",
        "hide_reactions_count": hideReactionsCount ? "1" : "0",
        "hide_views": hideViews ? "1" : "0",
        "hide_views_count": hideViewsCount ? "1" : "0",
        if (publishedAt != null) "published_at": publishedAt,

        if (type != "poll") "title": title,
        if (type != "poll") "content": content,

        if (pollQuestion != null) "question": pollQuestion,
        if (allowMultipleAnswers != null)
          "allow_multiple_answers": allowMultipleAnswers ? "1" : "0",
      };
      if (pollOptions != null) {
        for (int i = 0; i < pollOptions.length; i++) {
          if (pollOptions[i].trim().isNotEmpty) {
            fields["options[$i]"] = pollOptions[i];
          }
        }
      }

      final response = await api.multipartPost(
        endpoint: ApiConstants.createPost,
        fields: fields,
        files: media,
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return CreatePostModel.fromJson(decoded);
      }

      throw Exception(decoded["message"] ?? "Create post failed");
    } catch (e) {
      throw Exception("Create Post Error: $e");
    }
  }

  Future<GetMyPostsModel> getMyPosts({int page = 1}) async {
    try {
      final response = await api.get(
        "${ApiConstants.getMyPosts}?posts_page=$page",
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return GetMyPostsModel.fromJson(decodedResponse);
      }

      throw Exception(decodedResponse['message'] ?? 'Failed to get post');
    } catch (e) {
      throw Exception('Get post error: $e');
    }
  }
}
