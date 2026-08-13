class DataTimeLine {
  final int id;
  final int userId;
  final int value;
  final String? createdAt;
  final String? updatedAt;

  DataTimeLine({
    required this.id,
    required this.userId,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataTimeLine.fromJson(Map<String, dynamic> json) {
    return DataTimeLine(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      value: json['value'] ?? 0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class GetTimeLineModel {
  final bool success;
  final String message;
  final List<DataTimeLine> data;

  GetTimeLineModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetTimeLineModel.fromJson(Map<String, dynamic> json) {
    return GetTimeLineModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List? ?? [])
          .map((e) => DataTimeLine.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
