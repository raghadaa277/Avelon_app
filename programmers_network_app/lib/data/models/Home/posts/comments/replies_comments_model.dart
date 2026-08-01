import 'package:programmers_network_app/data/models/Home/posts/comments/get_post_comments_model.dart';

class GetCommentRepliesResponse {
  final bool success;
  final String message;
  final CommentsPaginatedData replies;

  GetCommentRepliesResponse({
    required this.success,
    required this.message,
    required this.replies,
  });

  factory GetCommentRepliesResponse.fromJson(Map<String, dynamic> json) {
    return GetCommentRepliesResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      replies: CommentsPaginatedData.fromJson(
        json['data'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': replies.toJson(),
  };
}
