class StatusHistory {
  final int id;
  final int userId;
  final String status;
  final String startedAt;
  final String? endedAt;
  final String reason;
  final DateTime createdAt;
  final DateTime updatedAt;

  StatusHistory({
    required this.id,
    required this.userId,
    required this.status,
    required this.startedAt,
    this.endedAt,
    required this.reason,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StatusHistory.fromJson(Map<String, dynamic> json) {
    return StatusHistory(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      status: json['status'] ?? '',
      startedAt: json['started_at'] ?? '',
      endedAt: json['ended_at'],
      reason: json['reason'] ?? '',
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}

class StatusSummaryModel {
  final int bannedCount;
  final int suspendedCount;
  final int activeCount;
  final int inactiveCount;

  StatusSummaryModel({
    required this.bannedCount,
    required this.suspendedCount,
    required this.activeCount,
    required this.inactiveCount,
  });

  factory StatusSummaryModel.fromJson(Map<String, dynamic> json) {
    return StatusSummaryModel(
      bannedCount: json['banned_count'] ?? 0,
      suspendedCount: json['suspended_count'] ?? 0,
      activeCount: json['active_count'] ?? 0,
      inactiveCount: json['inactive_count'] ?? 0,
    );
  }
}

class CurrentStatusModel {
  final int id;
  final int userId;
  final String status;
  final String startedAt;
  final String? endedAt;
  final String reason;
  final DateTime createdAt;
  final DateTime updatedAt;

  CurrentStatusModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.startedAt,
    this.endedAt,
    required this.reason,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CurrentStatusModel.fromJson(Map<String, dynamic> json) {
    return CurrentStatusModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      status: json['status'] ?? '',
      startedAt: json['started_at'] ?? '',
      endedAt: json['ended_at'],
      reason: json['reason'] ?? '',
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}

class DataUserStatusHistoryModel {
  final CurrentStatusModel currentStatus;
  final StatusSummaryModel statusSummary;
  final List<StatusHistory> statusHistories;

  DataUserStatusHistoryModel({
    required this.currentStatus,
    required this.statusSummary,
    required this.statusHistories,
  });

  factory DataUserStatusHistoryModel.fromJson(Map<String, dynamic> json) {
    return DataUserStatusHistoryModel(
      currentStatus: CurrentStatusModel.fromJson(json['current_status'] ?? {}),
      statusSummary: StatusSummaryModel.fromJson(json['status_summary'] ?? {}),
      statusHistories: (json['status_histories'] as List? ?? [])
          .map((e) => StatusHistory.fromJson(e))
          .toList(),
    );
  }
}

class UserStatusHistoryModel {
  final bool success;
  final String message;
  final DataUserStatusHistoryModel data;

  UserStatusHistoryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserStatusHistoryModel.fromJson(Map<String, dynamic> json) {
    return UserStatusHistoryModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: DataUserStatusHistoryModel.fromJson(json['data'] ?? {}),
    );
  }
}
/**{
    "success": true,
    "message": "User status retrieved successfully.",
    "data": {
        "current_status": {
            "id": 1,
            "user_id": 1,
            "status": "active",
            "started_at": "2026-06-16 13:54:46",
            "ended_at": null,
            "reason": "Account needs verification",
            "created_at": "2026-06-16T13:54:46.000000Z",
            "updated_at": "2026-06-16T13:54:46.000000Z"
        },
        "status_summary": {
            "banned_count": 0,
            "suspended_count": 0,
            "active_count": 1,
            "inactive_count": 0
        },
        "status_histories": [
            {
                "id": 1,
                "user_id": 1,
                "status": "active",
                "started_at": "2026-06-16 13:54:46",
                "ended_at": null,
                "reason": "Account needs verification",
                "created_at": "2026-06-16T13:54:46.000000Z",
                "updated_at": "2026-06-16T13:54:46.000000Z"
            }
        ]
    }
} */