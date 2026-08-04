class DeletePostMediaModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  DeletePostMediaModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DeletePostMediaModel.fromJson(Map<String, dynamic> json) {
    return DeletePostMediaModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
