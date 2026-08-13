class GetSuggestionsModel {
  final bool success;
  final String message;
  final SuggestionsPagination data;

  GetSuggestionsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetSuggestionsModel.fromJson(Map<String, dynamic> json) {
    return GetSuggestionsModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: SuggestionsPagination.fromJson(json['data'] ?? {}),
    );
  }
}

class SuggestionsPagination {
  final int currentPage;
  final List<SuggestionModel> suggestions;
  final int from;
  final int lastPage;
  final int perPage;
  final int to;
  final int total;
  final String? nextPageUrl;
  final String? prevPageUrl;

  SuggestionsPagination({
    required this.currentPage,
    required this.suggestions,
    required this.from,
    required this.lastPage,
    required this.perPage,
    required this.to,
    required this.total,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory SuggestionsPagination.fromJson(Map<String, dynamic> json) {
    return SuggestionsPagination(
      currentPage: json['current_page'] ?? 1,
      suggestions: (json['data'] as List? ?? [])
          .map((item) => SuggestionModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      from: json['from'] ?? 0,
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 0,
      to: json['to'] ?? 0,
      total: json['total'] ?? 0,
      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'],
    );
  }
}

class SuggestionModel {
  final int id;
  final int userId;
  final int suggestedUserId;
  final int score;
  final String createdAt;
  final String updatedAt;
  final SuggestedUserModel suggestedUser;

  SuggestionModel({
    required this.id,
    required this.userId,
    required this.suggestedUserId,
    required this.score,
    required this.createdAt,
    required this.updatedAt,
    required this.suggestedUser,
  });

  factory SuggestionModel.fromJson(Map<String, dynamic> json) {
    return SuggestionModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      suggestedUserId: json['suggested_user_id'] ?? 0,
      score: json['score'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      suggestedUser: SuggestedUserModel.fromJson(json['suggested_user'] ?? {}),
    );
  }
}

class SuggestedUserModel {
  final int id;
  final int roleId;
  final String fullName;
  final String email;
  final String? onboardingCompletedAt;
  final String createdAt;
  final String updatedAt;
  final UserProfileSuggestionModel userProfile;

  SuggestedUserModel({
    required this.id,
    required this.roleId,
    required this.fullName,
    required this.email,
    this.onboardingCompletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.userProfile,
  });

  factory SuggestedUserModel.fromJson(Map<String, dynamic> json) {
    return SuggestedUserModel(
      id: json['id'] ?? 0,
      roleId: json['role_id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      onboardingCompletedAt: json['onboarding_completed_at'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      userProfile: UserProfileSuggestionModel.fromJson(
        json['user_profile'] ?? {},
      ),
    );
  }
}

class UserProfileSuggestionModel {
  final int userId;
  final String username;
  final String? avatarFullUrl;

  UserProfileSuggestionModel({
    required this.userId,
    required this.username,
    this.avatarFullUrl,
  });

  factory UserProfileSuggestionModel.fromJson(Map<String, dynamic> json) {
    return UserProfileSuggestionModel(
      userId: json['user_id'] ?? 0,
      username: json['username'] ?? '',
      avatarFullUrl: json['avatar_full_url'],
    );
  }
}
