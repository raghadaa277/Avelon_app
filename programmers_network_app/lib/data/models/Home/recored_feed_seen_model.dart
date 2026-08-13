class RecordFeedSeenModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  RecordFeedSeenModel({
    required this.success,
    required this.message,
    required this.data,
  });
  factory RecordFeedSeenModel.fromJson(Map<String, dynamic> json) {
    return RecordFeedSeenModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
