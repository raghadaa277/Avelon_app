class FollowersModel {
  final bool success;
  final String message;
  final FollowersData data;

  FollowersModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FollowersModel.fromJson(Map<String, dynamic> json) {
    return FollowersModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: FollowersData.fromJson(json['data'] ?? {}),
    );
  }
}

class FollowersData {
  final int currentPage;
  final List<FollowerUser> followers;
  final int lastPage;
  final int total;
  final String? nextPageUrl;

  FollowersData({
    required this.currentPage,
    required this.followers,
    required this.lastPage,
    required this.total,
    this.nextPageUrl,
  });

  factory FollowersData.fromJson(Map<String, dynamic> json) {
    return FollowersData(
      currentPage: json['current_page'] ?? 1,
      followers: (json['data'] as List<dynamic>? ?? [])
          .map((e) => FollowerUser.fromJson(e))
          .toList(),
      lastPage: json['last_page'] ?? 1,
      total: json['total'] ?? 0,
      nextPageUrl: json['next_page_url'],
    );
  }
}

class FollowerUser {
  final int id;
  final int roleId;
  final String fullName;
  final String email;
  final String? onboardingCompletedAt;
  final String? createdAt;
  final String? updatedAt;
  final FollowerProfile userProfile;
  final FollowPivot pivot;

  FollowerUser({
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

  factory FollowerUser.fromJson(Map<String, dynamic> json) {
    return FollowerUser(
      id: json['id'] ?? 0,
      roleId: json['role_id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      onboardingCompletedAt: json['onboarding_completed_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userProfile: FollowerProfile.fromJson(json['user_profile'] ?? {}),
      pivot: FollowPivot.fromJson(json['pivot'] ?? {}),
    );
  }
}

class FollowerProfile {
  final int userId;
  final String username;
  final String? avatarFullUrl;

  FollowerProfile({
    required this.userId,
    required this.username,
    this.avatarFullUrl,
  });

  factory FollowerProfile.fromJson(Map<String, dynamic> json) {
    return FollowerProfile(
      userId: json['user_id'] ?? 0,
      username: json['username'] ?? '',
      avatarFullUrl: json['avatar_full_url'] ?? '',
    );
  }
}

class FollowPivot {
  final int followingId;
  final int followerId;
  final String? createdAt;
  final String? updatedAt;

  FollowPivot({
    required this.followingId,
    required this.followerId,
    this.createdAt,
    this.updatedAt,
  });

  factory FollowPivot.fromJson(Map<String, dynamic> json) {
    return FollowPivot(
      followingId: json['following_id'] ?? 0,
      followerId: json['follower_id'] ?? 0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
