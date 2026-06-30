class Usage {
  final DateTime date;
  final DateTime? firstOpenedAt;
  final DateTime lastSessionStart;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;
  final int id;

  Usage({
    required this.date,
    required this.firstOpenedAt,
    required this.lastSessionStart,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.id,
  });

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(
      date: DateTime.parse(json['date']),
      firstOpenedAt: json['first_opened_at'] != null
          ? DateTime.parse(json['first_opened_at'])
          : null,
      lastSessionStart: DateTime.parse(json['last_session_start']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      userId: json['user_id'] ?? 0,
      id: json['id'] ?? 0,
    );
  }
}

class DataStartUserModel {
  final Usage usage;

  DataStartUserModel({required this.usage});

  factory DataStartUserModel.fromJson(Map<String, dynamic> json) {
    if (json['usage'] == null) {
      throw Exception("usage is null");
    }
    return DataStartUserModel(usage: Usage.fromJson(json['usage']));
  }
}

class StartUserModel {
  final bool success;
  final String message;
  final DataStartUserModel data;

  StartUserModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory StartUserModel.fromJson(Map<String, dynamic> json) {
    return StartUserModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: DataStartUserModel.fromJson(json['data'] ?? {}),
    );
  }
}
