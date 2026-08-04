class ReactionsPostModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  ReactionsPostModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ReactionsPostModel.fromJson(Map<String, dynamic> json) {
    return ReactionsPostModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
