class DeleteCommentModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  DeleteCommentModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DeleteCommentModel.fromJson(Map<String, dynamic> json) {
    return DeleteCommentModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
