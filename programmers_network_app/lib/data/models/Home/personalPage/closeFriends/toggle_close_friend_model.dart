class ToggleCloseFriendModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  ToggleCloseFriendModel({
    required this.success,
    required this.message,
    required this.data,
  });
  factory ToggleCloseFriendModel.fromJson(Map<String, dynamic> json) {
    return ToggleCloseFriendModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
