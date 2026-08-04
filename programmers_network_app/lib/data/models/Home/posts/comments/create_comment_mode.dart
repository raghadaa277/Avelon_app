class DataCreateComment {
  final int postId;
  final int userId;
  int? parentId;
  final String content;
  DateTime? updatedAt;
  DateTime? createdAt;
  final int id;

  DataCreateComment({
    required this.id,
    required this.postId,
    required this.userId,
    this.parentId,
    this.updatedAt,
    required this.content,
    this.createdAt,
  });

  factory DataCreateComment.fromJson(Map<String, dynamic> json) {
    return DataCreateComment(
      id: json['id'] ?? 0,
      postId: json['post_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      parentId: json['parent_id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      content: json['content'] ?? '',
    );
  }
}

class CreateCommentMode {
  final bool success;
  final String message;
  final DataCreateComment data;

  CreateCommentMode({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CreateCommentMode.fromJSon(Map<String, dynamic> json) {
    return CreateCommentMode(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: DataCreateComment.fromJson(json['data'] ?? {}),
    );
  }
}
