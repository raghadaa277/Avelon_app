class CreatePostModel {
  final bool success;
  final String message;
  final PostData? data;

  CreatePostModel({required this.success, required this.message, this.data});

  factory CreatePostModel.fromJson(Map<String, dynamic> json) {
    return CreatePostModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null && json['data'] is Map
          ? PostData.fromJson(json['data'])
          : null,
    );
  }
}

class PostData {
  final int id;
  final String type;

  PostData({required this.id, required this.type});

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(id: json['id'] ?? 0, type: json['type'] ?? '');
  }
}

class PostType {
  final String type;
  final String label;
  const PostType({required this.type, required this.label});
}
