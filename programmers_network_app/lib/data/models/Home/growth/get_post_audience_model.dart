class GetPostAudienceModel {
  final int followersViews;
  final int nonFollowersViews;
  final double followersPercentage;
  final double nonFollowersPercentage;

  GetPostAudienceModel({
    required this.followersViews,
    required this.nonFollowersViews,
    required this.followersPercentage,
    required this.nonFollowersPercentage,
  });

  factory GetPostAudienceModel.fromJson(Map<String, dynamic> json) {
    return GetPostAudienceModel(
      followersViews: json['followers_views'] ?? 0,
      nonFollowersViews: json['non_followers_views'] ?? 0,
      followersPercentage:
          double.tryParse(json['followers_percentage']?.toString() ?? '0') ??
          0.0,
      nonFollowersPercentage:
          double.tryParse(
            json['non_followers_percentage']?.toString() ?? '0',
          ) ??
          0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'followers_views': followersViews,
      'non_followers_views': nonFollowersViews,
      'followers_percentage': followersPercentage,
      'non_followers_percentage': nonFollowersPercentage,
    };
  }
}

class GetPostAudienceResponseModel {
  final bool success;
  final String message;
  final GetPostAudienceModel data;

  GetPostAudienceResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetPostAudienceResponseModel.fromJson(Map<String, dynamic> json) {
    return GetPostAudienceResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: GetPostAudienceModel.fromJson(json['data'] ?? {}),
    );
  }
}
