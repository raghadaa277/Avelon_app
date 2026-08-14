class GrowthResponse {
  final bool success;
  final String message;
  final GrowthData data;

  GrowthResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GrowthResponse.fromJson(Map<String, dynamic> json) {
    return GrowthResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: GrowthData.fromJson(json['data'] ?? {}),
    );
  }
}

class GrowthData {
  final String period;
  final Growth growth;

  GrowthData({required this.period, required this.growth});

  factory GrowthData.fromJson(Map<String, dynamic> json) {
    return GrowthData(
      period: json['period'] ?? '',
      growth: Growth.fromJson(json['growth'] ?? {}),
    );
  }
}

class Growth {
  final ProfileViewsGrowthModel profileViews;
  final FollowersGrowthModel followers;
  final PostsGrowthModel posts;
  final LikesGrowthModel likes;
  final CommentsGrowthModel comments;
  final SavesGrowthModel saves;
  final SearchGrowthModel search;
  final SuggestionsGrowthModel suggestions;
  final OverallGrowthModel overall;

  Growth({
    required this.profileViews,
    required this.followers,
    required this.posts,
    required this.likes,
    required this.comments,
    required this.saves,
    required this.search,
    required this.suggestions,
    required this.overall,
  });

  factory Growth.fromJson(Map<String, dynamic> json) {
    return Growth(
      profileViews: ProfileViewsGrowthModel.fromJson(
        json['profile_views'] ?? {},
      ),
      followers: FollowersGrowthModel.fromJson(json['followers'] ?? {}),
      posts: PostsGrowthModel.fromJson(json['posts'] ?? {}),
      likes: LikesGrowthModel.fromJson(json['likes'] ?? {}),
      comments: CommentsGrowthModel.fromJson(json['comments'] ?? {}),
      saves: SavesGrowthModel.fromJson(json['saves'] ?? {}),
      search: SearchGrowthModel.fromJson(json['search'] ?? {}),
      suggestions: SuggestionsGrowthModel.fromJson(json['suggestions'] ?? {}),
      overall: OverallGrowthModel.fromJson(json['overall'] ?? {}),
    );
  }
}

class OverallGrowthModel {
  final double percentage;
  final String status;

  OverallGrowthModel({required this.percentage, required this.status});

  factory OverallGrowthModel.fromJson(Map<String, dynamic> json) {
    return OverallGrowthModel(
      percentage: (json['percentage'] ?? 0).toDouble(),
      status: json['status'] ?? '',
    );
  }
}

class SuggestionsGrowthModel {
  final double percentage;
  final String status;

  SuggestionsGrowthModel({required this.percentage, required this.status});

  factory SuggestionsGrowthModel.fromJson(Map<String, dynamic> json) {
    return SuggestionsGrowthModel(
      percentage: (json['percentage'] ?? 0).toDouble(),
      status: json['status'] ?? '',
    );
  }
}

class SearchGrowthModel {
  final double percentage;
  final String status;

  SearchGrowthModel({required this.percentage, required this.status});

  factory SearchGrowthModel.fromJson(Map<String, dynamic> json) {
    return SearchGrowthModel(
      percentage: (json['percentage'] ?? 0).toDouble(),
      status: json['status'] ?? '',
    );
  }
}

class CommentsGrowthModel {
  final double percentage;
  final String status;

  CommentsGrowthModel({required this.percentage, required this.status});

  factory CommentsGrowthModel.fromJson(Map<String, dynamic> json) {
    return CommentsGrowthModel(
      percentage: (json['percentage'] ?? 0).toDouble(),
      status: json['status'] ?? '',
    );
  }
}

class LikesGrowthModel {
  final double percentage;
  final String status;

  LikesGrowthModel({required this.percentage, required this.status});

  factory LikesGrowthModel.fromJson(Map<String, dynamic> json) {
    return LikesGrowthModel(
      percentage: (json['percentage'] ?? 0).toDouble(),
      status: json['status'] ?? '',
    );
  }
}

class PostsGrowthModel {
  final double percentage;
  final String status;

  PostsGrowthModel({required this.percentage, required this.status});

  factory PostsGrowthModel.fromJson(Map<String, dynamic> json) {
    return PostsGrowthModel(
      percentage: (json['percentage'] ?? 0).toDouble(),
      status: json['status'] ?? '',
    );
  }
}

class FollowersGrowthModel {
  final double percentage;
  final String status;

  FollowersGrowthModel({required this.percentage, required this.status});

  factory FollowersGrowthModel.fromJson(Map<String, dynamic> json) {
    return FollowersGrowthModel(
      percentage: (json['percentage'] ?? 0).toDouble(),
      status: json['status'] ?? '',
    );
  }
}

class ProfileViewsGrowthModel {
  final double percentage;
  final String status;

  ProfileViewsGrowthModel({required this.percentage, required this.status});

  factory ProfileViewsGrowthModel.fromJson(Map<String, dynamic> json) {
    return ProfileViewsGrowthModel(
      percentage: (json['percentage'] ?? 0).toDouble(),
      status: json['status'] ?? '',
    );
  }
}

class SavesGrowthModel {
  final double percentage;
  final String status;

  SavesGrowthModel({required this.percentage, required this.status});

  factory SavesGrowthModel.fromJson(Map<String, dynamic> json) {
    return SavesGrowthModel(
      percentage: (json['percentage'] ?? 0).toDouble(),
      status: json['status'] ?? '',
    );
  }
}
