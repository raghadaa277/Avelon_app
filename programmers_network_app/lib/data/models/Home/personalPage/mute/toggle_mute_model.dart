class ToggleMuteModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  ToggleMuteModel({
    required this.success,
    required this.message,
    required this.data,
  });
  factory ToggleMuteModel.fromJson(Map<String, dynamic> json) {
    return ToggleMuteModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
