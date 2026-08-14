class CreateQuestionModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  CreateQuestionModel({
    required this.success,
    required this.message,
    required this.data,
  });
  factory CreateQuestionModel.fromJson(Map<String, dynamic> json) {
    return CreateQuestionModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
