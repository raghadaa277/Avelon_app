class ToggleBlockModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  ToggleBlockModel({
    required this.success,
    required this.message,
    required this.data,
  });
  factory ToggleBlockModel.fromJson(Map<String, dynamic> json) {
    return ToggleBlockModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
