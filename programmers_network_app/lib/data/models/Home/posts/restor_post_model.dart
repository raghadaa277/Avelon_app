class RestorePostModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  RestorePostModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RestorePostModel.fromJson(Map<String, dynamic> json) {
    return RestorePostModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
