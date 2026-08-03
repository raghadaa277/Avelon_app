class CountsModel {
  final int followersCount;
  final int followingsCount;
  final int postsCount;

  CountsModel({
    required this.followersCount,
    required this.followingsCount,
    required this.postsCount,
  });
  CountsModel copyWith({
    int? followersCount,
    int? followingsCount,
    int? postsCount,
  }) {
    return CountsModel(
      followersCount: followersCount ?? this.followersCount,
      followingsCount: followingsCount ?? this.followingsCount,
      postsCount: postsCount ?? this.postsCount,
    );
  }

  factory CountsModel.fromJson(Map<String, dynamic> json) {
    return CountsModel(
      followersCount: json['followers_count'] ?? 0,
      followingsCount: json['followings_count'] ?? 0,
      postsCount: json['posts_count'] ?? 0,
    );
  }
}

class DataTargetUserCount {
  final CountsModel counts;

  DataTargetUserCount({required this.counts});

  factory DataTargetUserCount.fromJson(Map<String, dynamic> json) {
    return DataTargetUserCount(
      counts: CountsModel.fromJson(json['counts'] ?? {}),
    );
  }
}

class GetTargetUserCountModel {
  final bool success;
  final String message;
  final DataTargetUserCount data;

  GetTargetUserCountModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetTargetUserCountModel.fromJson(Map<String, dynamic> json) {
    return GetTargetUserCountModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: DataTargetUserCount.fromJson(json['data'] ?? {}),
    );
  }
}
