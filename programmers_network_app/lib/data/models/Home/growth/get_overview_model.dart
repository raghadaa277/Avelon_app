class DataOverviewModel {
  final int profileViews;
  final int followersCount;
  final int unfollowers;
  final int postCount;
  final int likesReceived;
  final int dislikeReceived;
  final int commentsReceived;
  final int saveReceived;
  final int profileSearchImpressions;
  final int postSearchImpressions;
  final int suggestionImpressions;

  DataOverviewModel({
    required this.profileViews,
    required this.followersCount,
    required this.unfollowers,
    required this.postCount,
    required this.likesReceived,
    required this.dislikeReceived,
    required this.commentsReceived,
    required this.saveReceived,
    required this.profileSearchImpressions,
    required this.postSearchImpressions,
    required this.suggestionImpressions,
  });

  factory DataOverviewModel.fromJson(Map<String, dynamic> json) {
    return DataOverviewModel(
      profileViews: int.tryParse(json['profile_views']?.toString() ?? '0') ?? 0,

      followersCount:
          int.tryParse(json['followers_count']?.toString() ?? '0') ?? 0,

      unfollowers: int.tryParse(json['unfollowers']?.toString() ?? '0') ?? 0,

      postCount: int.tryParse(json['posts_count']?.toString() ?? '0') ?? 0,

      likesReceived:
          int.tryParse(json['likes_received']?.toString() ?? '0') ?? 0,

      dislikeReceived:
          int.tryParse(json['dislikes_received']?.toString() ?? '0') ?? 0,

      commentsReceived:
          int.tryParse(json['comments_received']?.toString() ?? '0') ?? 0,

      saveReceived:
          int.tryParse(json['saves_received']?.toString() ?? '0') ?? 0,

      profileSearchImpressions:
          int.tryParse(json['profile_search_impressions']?.toString() ?? '0') ??
          0,

      postSearchImpressions:
          int.tryParse(json['post_search_impressions']?.toString() ?? '0') ?? 0,

      suggestionImpressions:
          int.tryParse(json['suggestion_impressions']?.toString() ?? '0') ?? 0,
    );
  }
}

class GetOverviewModel {
  final bool success;
  final String message;
  final DataOverviewModel data;

  GetOverviewModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetOverviewModel.fromJson(Map<String, dynamic> json) {
    return GetOverviewModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: DataOverviewModel.fromJson(json['data'] ?? {}),
    );
  }
}
