class ReactionsCommentsModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  ReactionsCommentsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ReactionsCommentsModel.fromJson(Map<String, dynamic> json) {
    return ReactionsCommentsModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
