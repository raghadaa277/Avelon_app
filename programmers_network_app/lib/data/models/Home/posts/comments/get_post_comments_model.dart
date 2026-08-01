class UserProfileComments {
  final int userId;
  final String? userName;
  final String? avatarFullUrl;

  UserProfileComments({
    required this.userId,
    this.userName,
    this.avatarFullUrl,
  });

  factory UserProfileComments.fromJson(Map<String, dynamic> json) {
    return UserProfileComments(
      userId: json['user_id'] ?? 0,
      userName: json['username'] ?? '',
      avatarFullUrl: json['avatar_full_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'username': userName,
    'avatar_full_url': avatarFullUrl,
  };
}

class UserPostComment {
  final UserProfileComments userProfileComments;
  final int id;
  final int roleId;
  final String fullName;
  final String email;
  final DateTime? onboardingCompletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserPostComment({
    required this.id,
    required this.roleId,
    required this.fullName,
    required this.email,
    required this.userProfileComments,
    this.onboardingCompletedAt,
    this.createdAt,
    this.updatedAt,
  });

  static DateTime? _toDate(dynamic v) =>
      v == null ? null : DateTime.tryParse(v.toString());

  factory UserPostComment.fromJson(Map<String, dynamic> json) {
    return UserPostComment(
      id: json['id'] ?? 0,
      roleId: json['role_id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      onboardingCompletedAt: _toDate(json['onboarding_completed_at']),
      createdAt: _toDate(json['created_at']),
      updatedAt: _toDate(json['updated_at']),
      userProfileComments: UserProfileComments.fromJson(
        json['user_profile'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'role_id': roleId,
    'full_name': fullName,
    'email': email,
    'onboarding_completed_at': onboardingCompletedAt?.toIso8601String(),
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'user_profile': userProfileComments.toJson(),
  };
}

class DataPostComments {
  final UserPostComment userPostComment;
  final int id;
  final int postId;
  final int userId;
  final int? parentId;
  final String content;
  final bool isPinned;
  final bool isBest;
  final bool isHidden;
  final int repliesCount;
  final int likesCount;
  final int disLikesCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isMyComment;
  final String reactionStatus;
  final bool repliesExists;

  DataPostComments({
    required this.id,
    required this.userPostComment,
    required this.userId,
    required this.postId,
    this.parentId,
    required this.content,
    required this.isPinned,
    required this.isBest,
    required this.isHidden,
    required this.repliesCount,
    required this.likesCount,
    required this.disLikesCount,
    this.createdAt,
    this.updatedAt,
    required this.isMyComment,
    required this.reactionStatus,
    required this.repliesExists,
  });

  static bool _toBool(dynamic v) => v == true || v == 1 || v == '1';

  static DateTime? _toDate(dynamic v) =>
      v == null ? null : DateTime.tryParse(v.toString());

  factory DataPostComments.fromJson(Map<String, dynamic> json) {
    return DataPostComments(
      id: json['id'] ?? 0,
      userPostComment: UserPostComment.fromJson(
        json['user'] as Map<String, dynamic>? ?? {},
      ),
      userId: json['user_id'] ?? 0,
      postId: json['post_id'] ?? 0,
      parentId: json['parent_id'],
      content: json['content'] ?? '',
      isPinned: _toBool(json['is_pinned']),
      isBest: _toBool(json['is_best']),
      isHidden: _toBool(json['is_hidden']),
      repliesCount: json['replies_count'] ?? 0,
      likesCount: json['likes_count'] ?? 0,
      disLikesCount: json['dislikes_count'] ?? 0,
      createdAt: _toDate(json['created_at']),
      updatedAt: _toDate(json['updated_at']),
      isMyComment: _toBool(json['is_my_comment']),
      reactionStatus: json['reaction_status'] ?? '',
      repliesExists: _toBool(json['replies_exists']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'post_id': postId,
    'user_id': userId,
    'parent_id': parentId,
    'content': content,
    'is_pinned': isPinned,
    'is_best': isBest,
    'is_hidden': isHidden,
    'replies_count': repliesCount,
    'likes_count': likesCount,
    'dislikes_count': disLikesCount,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'is_my_comment': isMyComment,
    'reaction_status': reactionStatus,
    'replies_exists': repliesExists,
    'user': userPostComment.toJson(),
  };
  DataPostComments copyWith({
    String? content,
    String? reactionStatus,
    int? likesCount,
    int? disLikesCount,
    int? repliesCount,
    bool? repliesExists,
  }) {
    return DataPostComments(
      id: id,
      userPostComment: userPostComment,
      userId: userId,
      postId: postId,
      parentId: parentId,
      content: content ?? this.content,
      isPinned: isPinned,
      isBest: isBest,
      isHidden: isHidden,
      repliesCount: repliesCount ?? this.repliesCount,
      likesCount: likesCount ?? this.likesCount,
      disLikesCount: disLikesCount ?? this.disLikesCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isMyComment: isMyComment,
      reactionStatus: reactionStatus ?? this.reactionStatus,
      repliesExists: repliesExists ?? this.repliesExists,
    );
  }
}

class CommentPageLink {
  final String? url;
  final String label;
  final int? page;
  final bool active;

  CommentPageLink({
    this.url,
    required this.label,
    this.page,
    required this.active,
  });

  factory CommentPageLink.fromJson(Map<String, dynamic> json) {
    return CommentPageLink(
      url: json['url'],
      label: json['label'] ?? '',
      page: json['page'],
      active: json['active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'url': url,
    'label': label,
    'page': page,
    'active': active,
  };
}

class CommentsPaginatedData {
  final int currentPage;
  final List<DataPostComments> data;
  final String? firstPageUrl;
  final int from;
  final int lastPage;
  final String? lastPageUrl;
  final List<CommentPageLink> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  CommentsPaginatedData({
    required this.currentPage,
    required this.data,
    this.firstPageUrl,
    required this.from,
    required this.lastPage,
    this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory CommentsPaginatedData.fromJson(Map<String, dynamic> json) {
    return CommentsPaginatedData(
      currentPage: json['current_page'] ?? 1,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => DataPostComments.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstPageUrl: json['first_page_url'],
      from: json['from'] ?? 0,
      lastPage: json['last_page'] ?? 1,
      lastPageUrl: json['last_page_url'],
      links: (json['links'] as List<dynamic>? ?? [])
          .map((e) => CommentPageLink.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPageUrl: json['next_page_url'],
      path: json['path'] ?? '',
      perPage: json['per_page'] ?? 0,
      prevPageUrl: json['prev_page_url'],
      to: json['to'] ?? 0,
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'data': data.map((e) => e.toJson()).toList(),
    'first_page_url': firstPageUrl,
    'from': from,
    'last_page': lastPage,
    'last_page_url': lastPageUrl,
    'links': links.map((e) => e.toJson()).toList(),
    'next_page_url': nextPageUrl,
    'path': path,
    'per_page': perPage,
    'prev_page_url': prevPageUrl,
    'to': to,
    'total': total,
  };
}

class PostCommentsResponse {
  final bool success;
  final String message;
  final CommentsPaginatedData comments;
  final bool isMyPost;

  PostCommentsResponse({
    required this.success,
    required this.message,
    required this.comments,
    required this.isMyPost,
  });

  factory PostCommentsResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    return PostCommentsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      comments: CommentsPaginatedData.fromJson(
        data['comments'] as Map<String, dynamic>? ?? {},
      ),
      isMyPost: data['is_my_post'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': {'comments': comments.toJson(), 'is_my_post': isMyPost},
  };
}
