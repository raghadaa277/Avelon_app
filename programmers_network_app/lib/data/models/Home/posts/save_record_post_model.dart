class SaveRecoedPostModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  SaveRecoedPostModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SaveRecoedPostModel.fromJSon(Map<String, dynamic> json) {
    return SaveRecoedPostModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}
