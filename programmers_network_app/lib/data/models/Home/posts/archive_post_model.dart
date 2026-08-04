class ArchivePostModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  ArchivePostModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ArchivePostModel.fromJson(Map<String, dynamic> json) {
    return ArchivePostModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
