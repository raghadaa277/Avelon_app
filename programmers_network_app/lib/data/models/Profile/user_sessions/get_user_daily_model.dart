class DailyUsage {
  final String date;
  final double totalHours;
  final int numberOfAppLaunches;

  DailyUsage({
    required this.date,
    required this.totalHours,
    required this.numberOfAppLaunches,
  });

  factory DailyUsage.fromJson(Map<String, dynamic> json) {
    return DailyUsage(
      date: json['date'] ?? '',
      totalHours: double.tryParse(json['total_hours'].toString()) ?? 0.0,
      numberOfAppLaunches: json['number_of_app_launches'] ?? 0,
    );
  }
}

class DailyUsageDetails {
  final double totalHours;
  final int numberOfAppLaunches;

  DailyUsageDetails({
    required this.totalHours,
    required this.numberOfAppLaunches,
  });

  factory DailyUsageDetails.fromJson(Map<String, dynamic> json) {
    return DailyUsageDetails(
      totalHours: double.tryParse(json['total_hours'].toString()) ?? 0.0,
      numberOfAppLaunches:
          int.tryParse(json['number_of_app_launches'].toString()) ?? 0,
    );
  }
}

class UserDailyUsageData {
  final List<DailyUsage> data;
  final DailyUsageDetails details;

  UserDailyUsageData({required this.data, required this.details});

  factory UserDailyUsageData.fromJson(Map<String, dynamic> json) {
    return UserDailyUsageData(
      data: _parseDailyUsageList(json['data']),
      details: DailyUsageDetails.fromJson(
        (json['details'] is Map<String, dynamic>)
            ? json['details'] as Map<String, dynamic>
            : {},
      ),
    );
  }

  static List<DailyUsage> _parseDailyUsageList(dynamic raw) {
    if (raw == null) return [];

    if (raw is List) {
      return raw
          .whereType<Map<String, dynamic>>()
          .map((e) => DailyUsage.fromJson(e))
          .toList();
    }

    if (raw is Map<String, dynamic>) {
      return [DailyUsage.fromJson(raw)];
    }

    return [];
  }
}

class UserDailyUsageModel {
  final bool success;
  final String message;
  final UserDailyUsageData data;

  UserDailyUsageModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserDailyUsageModel.fromJson(Map<String, dynamic> json) {
    return UserDailyUsageModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: UserDailyUsageData.fromJson(
        (json['data'] is Map<String, dynamic>)
            ? json['data'] as Map<String, dynamic>
            : {},
      ),
    );
  }
}
