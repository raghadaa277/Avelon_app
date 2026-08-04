class EditCommentModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  EditCommentModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory EditCommentModel.fromJson(Map<String, dynamic> json) {
    return EditCommentModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
