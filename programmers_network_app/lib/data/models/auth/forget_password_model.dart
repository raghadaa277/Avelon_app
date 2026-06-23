class ForgetPasswordModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  ForgetPasswordModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
