class CompleteModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  CompleteModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CompleteModel.fromJson(Map<String, dynamic> json) {
    return CompleteModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: List<dynamic>.from(json['data'] ?? []),
    );
  }
}
