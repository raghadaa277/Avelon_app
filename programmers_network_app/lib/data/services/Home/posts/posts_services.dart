import 'dart:convert';
import 'dart:io';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/posts/create_post_model.dart';

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
  }) async {
    try {
      final response = await api.multipartPost(
        endpoint: ApiConstants.createPost,
        fields: {
          "type": type,
          "title": title,
          "content": content,
          "visibility": visibility,
          "allow_comments": allowComments.toString(),
          "hide_comments_count": hideCommentsCount.toString(),
          "hide_reactions": hideReactions.toString(),
          "hide_reactions_count": hideReactionsCount.toString(),
          "hide_views": hideViews.toString(),
          "hide_views_count": hideViewsCount.toString(),
          if (publishedAt != null) "published_at": publishedAt,
        },
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
}
