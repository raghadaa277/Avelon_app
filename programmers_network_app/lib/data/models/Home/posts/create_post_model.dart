class CreatePostModel {
  final bool success;
  final String message;
  final List<dynamic> data;

  CreatePostModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CreatePostModel.fromJson(Map<String, dynamic> json) {
    return CreatePostModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
    );
  }
}

class PostType {
  final String type;
  final String label;

  const PostType({required this.type, required this.label});
}
