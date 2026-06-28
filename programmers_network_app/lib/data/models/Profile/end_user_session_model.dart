class EndUserSessionUsage {
  final int id;
  final int userId;
  final DateTime date;
  final String firstOpenedAt;
  final double totalSeconds;
  final int sessionCount;
  final DateTime lastSessionStart;
  final String lastSessionEnd;
  final DateTime createdAt;
  final DateTime updatedAt;

  EndUserSessionUsage({
    required this.id,
    required this.userId,
    required this.date,
    required this.firstOpenedAt,
    required this.totalSeconds,
    required this.sessionCount,
    required this.lastSessionStart,
    required this.lastSessionEnd,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EndUserSessionUsage.fromJson(Map<String, dynamic> json) {
    return EndUserSessionUsage(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      date: DateTime.parse(json['date']),
      firstOpenedAt: json['first_opened_at'] ?? '',
      totalSeconds: (json['total_seconds'] as num?)?.toDouble() ?? 0.0,
      sessionCount: json['session_count'] ?? 0,
      lastSessionStart: DateTime.parse(json['last_session_start']),
      lastSessionEnd: json['last_session_end'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class EndUserSessionData {
  final EndUserSessionUsage usage;

  EndUserSessionData({required this.usage});

  factory EndUserSessionData.fromJson(Map<String, dynamic> json) {
    return EndUserSessionData(
      usage: EndUserSessionUsage.fromJson(json['useage'] ?? {}),
    );
  }
}

class EndUserSessionModel {
  final bool success;
  final String message;
  final EndUserSessionData data;

  EndUserSessionModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory EndUserSessionModel.fromJson(Map<String, dynamic> json) {
    return EndUserSessionModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: EndUserSessionData.fromJson(json['data'] ?? {}),
    );
  }
}
