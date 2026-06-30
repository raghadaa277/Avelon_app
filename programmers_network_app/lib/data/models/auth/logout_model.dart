class LogoutModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  LogoutModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LogoutModel.fromJson(Map<String, dynamic> json) {
    return LogoutModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
