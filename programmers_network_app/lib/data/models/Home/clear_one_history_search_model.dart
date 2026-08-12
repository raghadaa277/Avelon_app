class ClearOneHistorySearchModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  ClearOneHistorySearchModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ClearOneHistorySearchModel.fromJson(Map<String, dynamic> json) {
    return ClearOneHistorySearchModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
