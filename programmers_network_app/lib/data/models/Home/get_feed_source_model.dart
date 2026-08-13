class GetFeedSourceModel {
  final bool success;
  final String message;
  final List<DataGetFeedSource> data;

  GetFeedSourceModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetFeedSourceModel.fromJson(Map<String, dynamic> json) {
    return GetFeedSourceModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List? ?? [])
          .map((e) => DataGetFeedSource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DataGetFeedSource {
  final int id;
  final int userFeedId;
  final String source;
  final String? createdAt;
  final String? updatedAt;

  DataGetFeedSource({
    required this.id,
    required this.userFeedId,
    required this.source,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataGetFeedSource.fromJson(Map<String, dynamic> json) {
    return DataGetFeedSource(
      id: json['id'] ?? 0,
      userFeedId: json['user_feed_id'] ?? 0,
      source: json['source'] ?? '',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
