class ReactionsModel {
  final bool success;
  final String message;
  final ReactionsData data;

  ReactionsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ReactionsModel.fromJson(Map<String, dynamic> json) {
    return ReactionsModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ReactionsData.fromJson(json['data'] ?? {}),
    );
  }
}

class ReactionsData {
  final int currentPage;
  final List<ReactionUser> reactions;
  final int lastPage;
  final int perPage;
  final int total;
  final String? nextPageUrl;
  final String? prevPageUrl;

  ReactionsData({
    required this.currentPage,
    required this.reactions,
    required this.lastPage,
    required this.perPage,
    required this.total,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory ReactionsData.fromJson(Map<String, dynamic> json) {
    return ReactionsData(
      currentPage: json['current_page'] ?? 1,
      reactions: (json['data'] as List? ?? [])
          .map((e) => ReactionUser.fromJson(e))
          .toList(),
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 20,
      total: json['total'] ?? 0,
      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'],
    );
  }
}

class ReactionUser {
  final int id;
  final int roleId;
  final String fullName;
  final String email;
  final String? onboardingCompletedAt;
  final String? createdAt;
  final String? updatedAt;
  final ReactionUserProfile userProfile;
  final ReactionPivot pivot;

  ReactionUser({
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

  factory ReactionUser.fromJson(Map<String, dynamic> json) {
    return ReactionUser(
      id: json['id'],
      roleId: json['role_id'],
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      onboardingCompletedAt: json['onboarding_completed_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userProfile: ReactionUserProfile.fromJson(json['user_profile'] ?? {}),
      pivot: ReactionPivot.fromJson(json['pivot'] ?? {}),
    );
  }
}

class ReactionUserProfile {
  final int userId;
  final String username;
  final String? avatarFullUrl;

  ReactionUserProfile({
    required this.userId,
    required this.username,
    this.avatarFullUrl,
  });

  factory ReactionUserProfile.fromJson(Map<String, dynamic> json) {
    return ReactionUserProfile(
      userId: json['user_id'] ?? 0,
      username: json['username'] ?? '',
      avatarFullUrl: json['avatar_full_url'],
    );
  }
}

class ReactionPivot {
  final int postId;
  final int userId;
  final String type;
  final String? createdAt;
  final String? updatedAt;

  ReactionPivot({
    required this.postId,
    required this.userId,
    required this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory ReactionPivot.fromJson(Map<String, dynamic> json) {
    return ReactionPivot(
      postId: json['post_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      type: json['type'] ?? '',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
