class UserFlagModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  UserFlagModel({
    required this.success,
    required this.message,
    required this.data,
  });
  factory UserFlagModel.fromJson(Map<String, dynamic> json) {
    return UserFlagModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
