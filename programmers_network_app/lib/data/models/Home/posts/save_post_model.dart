class SavePostModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  SavePostModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SavePostModel.fromJson(Map<String, dynamic> json) {
    return SavePostModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
