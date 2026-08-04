class DataTagPost {
  final int id;
  final String name;
  final String label;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DataTagPost({
    required this.id,
    required this.name,
    required this.label,
    this.createdAt,
    this.updatedAt,
  });

  factory DataTagPost.fromJson(Map<String, dynamic> json) {
    return DataTagPost(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      label: json['label'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}

class TagePostModel {
  final bool success;
  final String message;
  final List<DataTagPost> data;

  TagePostModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory TagePostModel.fromJson(Map<String, dynamic> json) {
    return TagePostModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => DataTagPost.fromJson(e))
              .toList() ??
          [],
    );
  }
}
