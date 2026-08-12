class ClearAllHistorySearchModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  ClearAllHistorySearchModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ClearAllHistorySearchModel.fromJson(Map<String, dynamic> json) {
    return ClearAllHistorySearchModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
