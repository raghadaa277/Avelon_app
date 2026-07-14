class ForceDeletePostModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  ForceDeletePostModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ForceDeletePostModel.fromJson(Map<String, dynamic> json) {
    return ForceDeletePostModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
