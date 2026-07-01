class AvatarActionResponseModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  AvatarActionResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AvatarActionResponseModel.fromJson(Map<String, dynamic> json) {
    return AvatarActionResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}