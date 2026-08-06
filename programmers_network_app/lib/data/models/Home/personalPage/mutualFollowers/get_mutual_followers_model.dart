class UserProfileMutualModel {
  final int userId;
  final String userName;
  final String? avatarFullUrl;

  UserProfileMutualModel({
    required this.userId,
    required this.userName,
    required this.avatarFullUrl,
  });

  factory UserProfileMutualModel.fromJson(Map<String, dynamic> json) {
    return UserProfileMutualModel(
      userId: json['user_id'] ?? 0,
      userName: json['username'] ?? '',
      avatarFullUrl: json['avatar_full_url'],
    );
  }
}

class MutualFollowerUser {
  final int id;
  final int roleId;
  final String fullName;
  final String email;
  final String onboardingCompletedAt;
  final String? createdAt;
  final String? updatedAt;
  final UserProfileMutualModel user;

  MutualFollowerUser({
    required this.id,
    required this.roleId,
    required this.fullName,
    required this.email,
    required this.onboardingCompletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory MutualFollowerUser.fromJson(Map<String, dynamic> json) {
    return MutualFollowerUser(
      id: json['id'] ?? 0,
      roleId: json['role_id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      onboardingCompletedAt: json['onboarding_completed_at'] ?? '',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: UserProfileMutualModel.fromJson(json['user_profile'] ?? {}),
    );
  }
}

class MutualFollowersPagination {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final List<MutualFollowerUser> users;

  MutualFollowersPagination({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.users,
  });

  factory MutualFollowersPagination.fromJson(Map<String, dynamic> json) {
    return MutualFollowersPagination(
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 20,
      total: json['total'] ?? 0,
      users: (json['data'] as List<dynamic>? ?? [])
          .map((e) => MutualFollowerUser.fromJson(e))
          .toList(),
    );
  }
}

class GetMutualFollowersModel {
  final bool success;
  final String message;
  final MutualFollowersPagination data;

  GetMutualFollowersModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetMutualFollowersModel.fromJson(Map<String, dynamic> json) {
    return GetMutualFollowersModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: MutualFollowersPagination.fromJson(json['data'] ?? {}),
    );
  }
}
