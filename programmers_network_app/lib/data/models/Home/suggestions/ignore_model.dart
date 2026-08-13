class IgnoreModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  IgnoreModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory IgnoreModel.fromJson(Map<String, dynamic> json) {
    return IgnoreModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
