class SearchResponseModel {
  final bool success;
  final String message;
  final SearchDataModel data;

  SearchResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) {
    return SearchResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: SearchDataModel.fromJson(json['data']),
    );
  }
}

class SearchDataModel {
  final int currentPage;
  final List<SearchUserModel> users;
  final int lastPage;
  final int total;
  final int perPage;
  final String path;
  final String? nextPageUrl;
  final String? prevPageUrl;

  SearchDataModel({
    required this.currentPage,
    required this.users,
    required this.lastPage,
    required this.total,
    required this.perPage,
    required this.path,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory SearchDataModel.fromJson(Map<String, dynamic> json) {
    return SearchDataModel(
      currentPage: json['current_page'] ?? 1,

      users: (json['data'] as List? ?? [])
          .map((e) => SearchUserModel.fromJson(e))
          .toList(),

      lastPage: json['last_page'] ?? 1,
      total: json['total'] ?? 0,
      perPage: json['per_page'] ?? 0,
      path: json['path'] ?? '',

      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'],
    );
  }
}

class SearchUserModel {
  final int id;
  final int roleId;
  final String fullName;
  final String email;
  final String userName;

  final String? onboardingCompletedAt;

  final String? createdAt;
  final String? updatedAt;

  final String followStatus;
  final int followingOrder;
  final int searchOrder;

  final UserProfileModel? userProfile;

  SearchUserModel({
    required this.id,
    required this.roleId,
    required this.fullName,
    required this.email,
    this.onboardingCompletedAt,
    this.createdAt,
    this.updatedAt,
    required this.followStatus,
    required this.followingOrder,
    required this.searchOrder,
    this.userProfile,
    required this.userName,
  });

  factory SearchUserModel.fromJson(Map<String, dynamic> json) {
    return SearchUserModel(
      id: json['id'] ?? 0,
      roleId: json['role_id'] ?? 0,

      fullName: json['full_name'] ?? '',

      email: json['email'] ?? '',

      onboardingCompletedAt: json['onboarding_completed_at'],

      createdAt: json['created_at'],

      updatedAt: json['updated_at'],

      followStatus: json['follow_status'] ?? 'none',

      followingOrder: json['following_order'] ?? 0,

      searchOrder: json['search_order'] ?? 0,

      userProfile: json['user_profile'] != null
          ? UserProfileModel.fromJson(json['user_profile'])
          : null,

      userName: json['username'] ?? '',
    );
  }
}

class UserProfileModel {
  final int userId;
  final String? avatarFullUrl;

  UserProfileModel({required this.userId, this.avatarFullUrl});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: json['user_id'] ?? 0,
      avatarFullUrl: json['avatar_full_url'],
    );
  }
}
