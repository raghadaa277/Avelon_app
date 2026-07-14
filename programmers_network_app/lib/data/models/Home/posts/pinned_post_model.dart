class PinnedPostModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  PinnedPostModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PinnedPostModel.fromJson(Map<String, dynamic> json) {
    return PinnedPostModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
