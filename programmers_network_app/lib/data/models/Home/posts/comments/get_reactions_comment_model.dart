class GetReactionsCommentModel {
  final bool success;
  final String message;
  final GetReactionsCommentData data;

  GetReactionsCommentModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetReactionsCommentModel.fromJson(Map<String, dynamic> json) {
    return GetReactionsCommentModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: GetReactionsCommentData.fromJson(json['data'] ?? {}),
    );
  }
}

class GetReactionsCommentData {
  final int currentPage;
  final List<GetReactionCommentUser> reactions;
  final int lastPage;
  final int perPage;
  final int total;
  final String? nextPageUrl;
  final String? prevPageUrl;

  GetReactionsCommentData({
    required this.currentPage,
    required this.reactions,
    required this.lastPage,
    required this.perPage,
    required this.total,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory GetReactionsCommentData.fromJson(Map<String, dynamic> json) {
    return GetReactionsCommentData(
      currentPage: json['current_page'] ?? 1,

      reactions: (json['data'] as List? ?? [])
          .map((e) => GetReactionCommentUser.fromJson(e))
          .toList(),

      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 20,
      total: json['total'] ?? 0,

      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'],
    );
  }
}

class GetReactionCommentUser {
  final int id;
  final int roleId;
  final String fullName;
  final String email;
  final String? onboardingCompletedAt;
  final String? createdAt;
  final String? updatedAt;

  final GetReactionCommentUserProfile userProfile;
  final GetReactionCommentPivot pivot;

  GetReactionCommentUser({
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

  factory GetReactionCommentUser.fromJson(Map<String, dynamic> json) {
    return GetReactionCommentUser(
      id: json['id'] ?? 0,
      roleId: json['role_id'] ?? 0,

      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',

      onboardingCompletedAt: json['onboarding_completed_at'],

      createdAt: json['created_at'],

      updatedAt: json['updated_at'],

      userProfile: GetReactionCommentUserProfile.fromJson(
        json['user_profile'] ?? {},
      ),

      pivot: GetReactionCommentPivot.fromJson(json['pivot'] ?? {}),
    );
  }
}

class GetReactionCommentUserProfile {
  final int userId;
  final String? username;
  final String? avatarFullUrl;

  GetReactionCommentUserProfile({
    required this.userId,
    this.username,
    this.avatarFullUrl,
  });

  factory GetReactionCommentUserProfile.fromJson(Map<String, dynamic> json) {
    return GetReactionCommentUserProfile(
      userId: json['user_id'] ?? 0,

      username: json['username'],

      avatarFullUrl: json['avatar_full_url'],
    );
  }
}

class GetReactionCommentPivot {
  final int commentId;
  final int userId;
  final String type;

  final String? createdAt;
  final String? updatedAt;

  GetReactionCommentPivot({
    required this.commentId,
    required this.userId,
    required this.type,

    this.createdAt,
    this.updatedAt,
  });

  factory GetReactionCommentPivot.fromJson(Map<String, dynamic> json) {
    return GetReactionCommentPivot(
      commentId: json['comment_id'] ?? 0,

      userId: json['user_id'] ?? 0,

      type: json['type'] ?? '',

      createdAt: json['created_at'],

      updatedAt: json['updated_at'],
    );
  }
}
