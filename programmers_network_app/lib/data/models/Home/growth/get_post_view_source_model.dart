class PostViewsOverviewModel {
  final int totalViews;
  final int feedCount;
  final int searchCount;
  final int profileCount;
  final double feedPercentage;
  final double searchPercentage;
  final double profilePercentage;

  PostViewsOverviewModel({
    required this.totalViews,
    required this.feedCount,
    required this.searchCount,
    required this.profileCount,
    required this.feedPercentage,
    required this.searchPercentage,
    required this.profilePercentage,
  });

  factory PostViewsOverviewModel.fromJson(Map<String, dynamic> json) {
    return PostViewsOverviewModel(
      totalViews: int.tryParse(json['total_views'].toString()) ?? 0,
      feedCount: int.tryParse(json['feed_count'].toString()) ?? 0,
      searchCount: int.tryParse(json['search_count'].toString()) ?? 0,
      profileCount: int.tryParse(json['profile_count'].toString()) ?? 0,
      feedPercentage:
          double.tryParse(json['feed_percentage'].toString()) ?? 0.0,
      searchPercentage:
          double.tryParse(json['search_percentage'].toString()) ?? 0.0,
      profilePercentage:
          double.tryParse(json['profile_percentage'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_views': totalViews,
      'feed_count': feedCount,
      'search_count': searchCount,
      'profile_count': profileCount,
      'feed_percentage': feedPercentage,
      'search_percentage': searchPercentage,
      'profile_percentage': profilePercentage,
    };
  }
}

class PostViewsOverviewResponseModel {
  final bool success;
  final String message;
  final PostViewsOverviewModel data;

  PostViewsOverviewResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PostViewsOverviewResponseModel.fromJson(Map<String, dynamic> json) {
    return PostViewsOverviewResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: PostViewsOverviewModel.fromJson(json['data'] ?? {}),
    );
  }
}
