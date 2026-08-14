class ManageCommentModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  ManageCommentModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ManageCommentModel.fromJson(Map<String, dynamic> json) {
    return ManageCommentModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
