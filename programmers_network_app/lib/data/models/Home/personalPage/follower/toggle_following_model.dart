class ToggleFollowingModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  ToggleFollowingModel({
    required this.success,
    required this.message,
    required this.data,
  });
  factory ToggleFollowingModel.fromJson(Map<String, dynamic> json) {
    return ToggleFollowingModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
