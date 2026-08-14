class DataOverviewPost {
  final int uniqueViewers;
  final int totalViews;
  final double averageViewsPerUser;

  DataOverviewPost({
    required this.uniqueViewers,
    required this.totalViews,
    required this.averageViewsPerUser,
  });

  factory DataOverviewPost.fromJson(Map<String, dynamic> json) {
    return DataOverviewPost(
      uniqueViewers:
          int.tryParse(json['unique_viewers']?.toString() ?? '0') ?? 0,

      totalViews: int.tryParse(json['total_views']?.toString() ?? '0') ?? 0,

      averageViewsPerUser:
          double.tryParse(json['average_views_per_user']?.toString() ?? '0') ??
          0.0,
    );
  }
}

class GetOverviewPostModel {
  final bool success;
  final String message;
  final DataOverviewPost data;

  GetOverviewPostModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetOverviewPostModel.fromJson(Map<String, dynamic> json) {
    return GetOverviewPostModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: DataOverviewPost.fromJson(json['data'] ?? {}),
    );
  }
}
