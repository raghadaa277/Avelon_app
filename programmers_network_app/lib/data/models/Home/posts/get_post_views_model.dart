class PostViewModel {
  final bool success;
  final String message;
  final PostViewsData data;

  PostViewModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PostViewModel.fromJson(Map<String, dynamic> json) {
    return PostViewModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: PostViewsData.fromJson(json['data'] ?? {}),
    );
  }
}

class PostViewsData {
  final int currentPage;
  final List<ViewUser> users;
  final int lastPage;
  final int perPage;
  final int total;
  final String? nextPageUrl;
  final String? prevPageUrl;

  PostViewsData({
    required this.currentPage,
    required this.users,
    required this.lastPage,
    required this.perPage,
    required this.total,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory PostViewsData.fromJson(Map<String, dynamic> json) {
    return PostViewsData(
      currentPage: json['current_page'] ?? 1,
      users: (json['data'] as List? ?? [])
          .map((e) => ViewUser.fromJson(e))
          .toList(),
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 20,
      total: json['total'] ?? 0,
      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'],
    );
  }
}

class ViewUser {
  final int id;
  final int roleId;
  final String fullName;
  final String email;
  final String? onboardingCompletedAt;
  final String? createdAt;
  final String? updatedAt;

  final ViewUserProfile userProfile;
  final ViewPivot pivot;

  ViewUser({
    required this.id,
    required this.roleId,
    required this.fullName,
    required this.email,
    this.onboardingCompletedAt,
    this.createdAt,
    this.updatedAt,
    required this.userProfile,
    required this.pivot,
  });

  factory ViewUser.fromJson(Map<String, dynamic> json) {
    return ViewUser(
      id: json['id'] ?? 0,
      roleId: json['role_id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      onboardingCompletedAt: json['onboarding_completed_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userProfile: ViewUserProfile.fromJson(json['user_profile'] ?? {}),
      pivot: ViewPivot.fromJson(json['pivot'] ?? {}),
    );
  }
}

class ViewUserProfile {
  final int userId;
  final String username;
  final String? avatarFullUrl;

  ViewUserProfile({
    required this.userId,
    required this.username,
    this.avatarFullUrl,
  });

  factory ViewUserProfile.fromJson(Map<String, dynamic> json) {
    return ViewUserProfile(
      userId: json['user_id'] ?? 0,
      username: json['username'] ?? '',
      avatarFullUrl: json['avatar_full_url'],
    );
  }
}

class ViewPivot {
  final int postId;
  final int userId;
  final bool isFollower;
  final String source;
  final String? lastViewedAt;
  final int viewCount;
  final String? createdAt;
  final String? updatedAt;

  ViewPivot({
    required this.postId,
    required this.userId,
    required this.isFollower,
    required this.source,
    this.lastViewedAt,
    required this.viewCount,
    this.createdAt,
    this.updatedAt,
  });

  factory ViewPivot.fromJson(Map<String, dynamic> json) {
    return ViewPivot(
      postId: json['post_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      isFollower: (json['is_follower'] ?? 0) == 1,
      source: json['source'] ?? '',
      lastViewedAt: json['last_viewed_at'],
      viewCount: json['view_count'] ?? 0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
