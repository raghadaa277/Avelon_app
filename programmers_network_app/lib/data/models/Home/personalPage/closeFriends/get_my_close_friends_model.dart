class GetCloseFriendsModel {
  final bool success;
  final String message;
  final CloseFriendsData data;

  GetCloseFriendsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetCloseFriendsModel.fromJson(Map<String, dynamic> json) {
    return GetCloseFriendsModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: CloseFriendsData.fromJson(json['data'] ?? {}),
    );
  }
}

class CloseFriendsData {
  final int currentPage;
  final List<CloseFriendUser> users;

  final int lastPage;
  final int total;

  CloseFriendsData({
    required this.currentPage,
    required this.users,
    required this.lastPage,
    required this.total,
  });

  factory CloseFriendsData.fromJson(Map<String, dynamic> json) {
    return CloseFriendsData(
      currentPage: json['current_page'] ?? 1,

      users: (json['data'] as List? ?? [])
          .map((e) => CloseFriendUser.fromJson(e))
          .toList(),

      lastPage: json['last_page'] ?? 1,

      total: json['total'] ?? 0,
    );
  }
}

class CloseFriendUser {
  final int id;
  final int roleId;

  final String fullName;
  final String email;

  final String? onboardingCompletedAt;

  final String createdAt;
  final String updatedAt;

  final CloseFriendPivot? pivot;

  CloseFriendUser({
    required this.id,
    required this.roleId,
    required this.fullName,
    required this.email,
    this.onboardingCompletedAt,
    required this.createdAt,
    required this.updatedAt,
    this.pivot,
  });

  factory CloseFriendUser.fromJson(Map<String, dynamic> json) {
    return CloseFriendUser(
      id: json['id'] ?? 0,

      roleId: json['role_id'] ?? 0,

      fullName: json['full_name'] ?? '',

      email: json['email'] ?? '',

      onboardingCompletedAt: json['onboarding_completed_at'],

      createdAt: json['created_at'] ?? '',

      updatedAt: json['updated_at'] ?? '',

      pivot: json['pivot'] != null
          ? CloseFriendPivot.fromJson(json['pivot'])
          : null,
    );
  }
}

class CloseFriendPivot {
  final int userId;
  final int closeFriendId;

  final String? createdAt;
  final String? updatedAt;

  CloseFriendPivot({
    required this.userId,
    required this.closeFriendId,
    this.createdAt,
    this.updatedAt,
  });

  factory CloseFriendPivot.fromJson(Map<String, dynamic> json) {
    return CloseFriendPivot(
      userId: json['user_id'] ?? 0,

      closeFriendId: json['close_friend_id'] ?? 0,

      createdAt: json['created_at'],

      updatedAt: json['updated_at'],
    );
  }
}
