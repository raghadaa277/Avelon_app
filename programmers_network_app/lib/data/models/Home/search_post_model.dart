class PostSearchResponse {
  final bool success;
  final String message;
  final PostPaginatedData data;

  PostSearchResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PostSearchResponse.fromJson(Map<String, dynamic> json) {
    return PostSearchResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: PostPaginatedData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data.toJson(),
  };
}

const String _notSetSentinel = '__NOT_SET_SENTINEL__';

class PostPaginatedData {
  final int currentPage;
  final List<Post> data;
  final String? firstPageUrl;
  final int from;
  final int lastPage;
  final String? lastPageUrl;
  final List<PageLink> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  PostPaginatedData({
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

  factory PostPaginatedData.fromJson(Map<String, dynamic> json) {
    return PostPaginatedData(
      currentPage: json['current_page'] ?? 1,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstPageUrl: json['first_page_url'],
      from: json['from'] ?? 0,
      lastPage: json['last_page'] ?? 1,
      lastPageUrl: json['last_page_url'],
      links: (json['links'] as List<dynamic>? ?? [])
          .map((e) => PageLink.fromJson(e as Map<String, dynamic>))
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

class PageLink {
  final String? url;
  final String label;
  final int? page;
  final bool active;

  PageLink({this.url, required this.label, this.page, required this.active});

  factory PageLink.fromJson(Map<String, dynamic> json) {
    return PageLink(
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

class Post {
  final int id;
  final int userId;
  final String status;
  final String type;
  final String title;
  final String content;
  final String visibility;
  final bool allowComments;
  final bool hideCommentsCount;
  final bool hideReactions;
  final bool hideReactionsCount;
  final bool hideShares;
  final bool hideViews;
  final bool hideViewsCount;
  final bool isEdited;
  final DateTime? editedAt;
  final bool isPinned;
  final DateTime? publishedAt;
  final DateTime? deletedAt;
  final int likesCount;
  final int disLikesCount;
  final int commentsCount;
  final int viewsCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? followingOrder;
  final int? searchOrder;
  final String? reactionStatus;
  final bool isSaved;
  final bool isViewed;
  final String? followStatus;
  final List<PostMedia> postMedia;
  final Poll? poll;
  final List<Viewer> viewers;
  final PostUser user;

  Post({
    required this.id,
    required this.userId,
    required this.status,
    required this.type,
    required this.title,
    required this.content,
    required this.visibility,
    required this.allowComments,
    required this.hideCommentsCount,
    required this.hideReactions,
    required this.hideReactionsCount,
    required this.hideShares,
    required this.hideViews,
    required this.hideViewsCount,
    required this.isEdited,
    this.editedAt,
    required this.isPinned,
    this.publishedAt,
    this.deletedAt,
    required this.likesCount,
    required this.disLikesCount,
    required this.commentsCount,
    required this.viewsCount,
    this.createdAt,
    this.updatedAt,
    this.followingOrder,
    this.searchOrder,
    this.reactionStatus,
    required this.isSaved,
    required this.isViewed,
    this.followStatus,
    required this.postMedia,
    this.poll,
    required this.viewers,
    required this.user,
  });

  Post copyWith({
    int? likesCount,
    int? disLikesCount,
    String reactionStatus = _notSetSentinel,
    bool? isSaved,
    bool? isViewed,
    List<Viewer>? viewers,
  }) {
    return Post(
      id: id,
      userId: userId,
      status: status,
      type: type,
      title: title,
      content: content,
      visibility: visibility,
      allowComments: allowComments,
      hideCommentsCount: hideCommentsCount,
      hideReactions: hideReactions,
      hideReactionsCount: hideReactionsCount,
      hideShares: hideShares,
      hideViews: hideViews,
      hideViewsCount: hideViewsCount,
      isEdited: isEdited,
      editedAt: editedAt,
      isPinned: isPinned,
      publishedAt: publishedAt,
      deletedAt: deletedAt,
      likesCount: likesCount ?? this.likesCount,
      disLikesCount: disLikesCount ?? this.disLikesCount,
      commentsCount: commentsCount,
      viewsCount: viewsCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
      followingOrder: followingOrder,
      searchOrder: searchOrder,
      reactionStatus: reactionStatus == _notSetSentinel
          ? this.reactionStatus
          : (reactionStatus.isEmpty ? null : reactionStatus),
      isSaved: isSaved ?? this.isSaved,
      isViewed: isViewed ?? this.isViewed,
      followStatus: followStatus,
      postMedia: postMedia,
      poll: poll,
      viewers: viewers ?? this.viewers,
      user: user,
    );
  }

  static bool _toBool(dynamic v) => v == true || v == 1 || v == '1';

  static DateTime? _toDate(dynamic v) =>
      v == null ? null : DateTime.tryParse(v.toString());

  factory Post.fromJson(Map<String, dynamic> json) {
    String? reactionStatus = json['reaction_status'];

    if (reactionStatus == null ||
        reactionStatus.isEmpty ||
        reactionStatus == 'null' ||
        reactionStatus == 'nolike') {
      reactionStatus = null;
    }

    return Post(
      id: json['id'],
      userId: json['user_id'],
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      visibility: json['visibility'] ?? '',
      allowComments: _toBool(json['allow_comments']),
      hideCommentsCount: _toBool(json['hide_comments_count']),
      hideReactions: _toBool(json['hide_reactions']),
      hideReactionsCount: _toBool(json['hide_reactions_count']),
      hideShares: _toBool(json['hide_shares']),
      hideViews: _toBool(json['hide_views']),
      hideViewsCount: _toBool(json['hide_views_count']),
      isEdited: _toBool(json['is_edited']),
      editedAt: _toDate(json['edited_at']),
      isPinned: _toBool(json['is_pinned']),
      publishedAt: _toDate(json['published_at']),
      deletedAt: _toDate(json['deleted_at']),
      likesCount: json['likes_count'] ?? 0,
      disLikesCount: json['dislikes_count'] ?? 0,
      commentsCount: json['comments_count'] ?? 0,
      viewsCount: json['views_count'] ?? 0,
      createdAt: _toDate(json['created_at']),
      updatedAt: _toDate(json['updated_at']),
      followingOrder: json['following_order'],
      searchOrder: json['search_order'],
      reactionStatus: reactionStatus,
      isSaved: _toBool(json['is_saved']),
      isViewed: _toBool(json['is_viewed']),
      followStatus: json['follow_status'],
      postMedia: (json['post_media'] as List<dynamic>? ?? [])
          .map((e) => PostMedia.fromJson(e as Map<String, dynamic>))
          .toList(),
      poll: json['poll'] == null
          ? null
          : Poll.fromJson(json['poll'] as Map<String, dynamic>),
      viewers: (json['viewers'] as List<dynamic>? ?? [])
          .map((e) => Viewer.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: PostUser.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'status': status,
    'type': type,
    'title': title,
    'content': content,
    'visibility': visibility,
    'allow_comments': allowComments,
    'hide_comments_count': hideCommentsCount,
    'hide_reactions': hideReactions,
    'hide_reactions_count': hideReactionsCount,
    'hide_shares': hideShares,
    'hide_views': hideViews,
    'hide_views_count': hideViewsCount,
    'is_edited': isEdited,
    'edited_at': editedAt?.toIso8601String(),
    'is_pinned': isPinned,
    'published_at': publishedAt?.toIso8601String(),
    'deleted_at': deletedAt?.toIso8601String(),
    'likes_count': likesCount,
    'comments_count': commentsCount,
    'views_count': viewsCount,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'following_order': followingOrder,
    'search_order': searchOrder,
    'reaction_status': reactionStatus,
    'is_saved': isSaved,
    'is_viewed': isViewed,
    'follow_status': followStatus,
    'post_media': postMedia.map((e) => e.toJson()).toList(),
    'poll': poll?.toJson(),
    'viewers': viewers.map((e) => e.toJson()).toList(),
    'user': user.toJson(),
  };
}

class PostMedia {
  final int id;
  final int postId;
  final String mimeType;
  final int size;
  final int width;
  final int height;
  final int order;
  final String status;
  final String? errorMessage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String mediaFullUrl;

  PostMedia({
    required this.id,
    required this.postId,
    required this.mimeType,
    required this.size,
    required this.width,
    required this.height,
    required this.order,
    required this.status,
    this.errorMessage,
    this.createdAt,
    this.updatedAt,
    required this.mediaFullUrl,
  });

  factory PostMedia.fromJson(Map<String, dynamic> json) {
    return PostMedia(
      id: json['id'],
      postId: json['post_id'],
      mimeType: json['mime_type'] ?? '',
      size: json['size'] ?? 0,
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      order: json['order'] ?? 0,
      status: json['status'] ?? '',
      errorMessage: json['error_message'],
      createdAt: Post._toDate(json['created_at']),
      updatedAt: Post._toDate(json['updated_at']),
      mediaFullUrl: json['media_full_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'post_id': postId,
    'mime_type': mimeType,
    'size': size,
    'width': width,
    'height': height,
    'order': order,
    'status': status,
    'error_message': errorMessage,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'media_full_url': mediaFullUrl,
  };
}

class Poll {
  final int? id;
  final int? postId;
  final String? question;
  final List<dynamic>? options;
  final DateTime? expiresAt;

  Poll({this.id, this.postId, this.question, this.options, this.expiresAt});

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      id: json['id'],
      postId: json['post_id'],
      question: json['question'],
      options: json['options'],
      expiresAt: Post._toDate(json['expires_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'post_id': postId,
    'question': question,
    'options': options,
    'expires_at': expiresAt?.toIso8601String(),
  };
}

class Viewer extends PostUser {
  final ViewerPivot pivot;

  Viewer({
    required int id,
    required int roleId,
    required String fullName,
    required String email,
    DateTime? onboardingCompletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserProfile? userProfile,
    required this.pivot,
  }) : super(
         id: id,
         roleId: roleId,
         fullName: fullName,
         email: email,
         onboardingCompletedAt: onboardingCompletedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
         userProfile: userProfile,
       );

  Viewer copyWith({ViewerPivot? pivot}) {
    return Viewer(
      id: id,
      roleId: roleId,
      fullName: fullName,
      email: email,
      onboardingCompletedAt: onboardingCompletedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      userProfile: userProfile,
      pivot: pivot ?? this.pivot,
    );
  }

  factory Viewer.fromJson(Map<String, dynamic> json) {
    return Viewer(
      id: json['id'],
      roleId: json['role_id'],
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      onboardingCompletedAt: Post._toDate(json['onboarding_completed_at']),
      createdAt: Post._toDate(json['created_at']),
      updatedAt: Post._toDate(json['updated_at']),
      userProfile: json['user_profile'] == null
          ? null
          : UserProfile.fromJson(json['user_profile'] as Map<String, dynamic>),
      pivot: ViewerPivot.fromJson(json['pivot'] as Map<String, dynamic>? ?? {}),
    );
  }

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'pivot': pivot.toJson()};
}

class ViewerPivot {
  final int postId;
  final int userId;
  final bool isFollower;
  final String source;
  final DateTime? lastViewedAt;
  final int viewCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ViewerPivot({
    required this.postId,
    required this.userId,
    required this.isFollower,
    required this.source,
    this.lastViewedAt,
    required this.viewCount,
    this.createdAt,
    this.updatedAt,
  });

  ViewerPivot copyWith({int? viewCount, DateTime? lastViewedAt}) {
    return ViewerPivot(
      postId: postId,
      userId: userId,
      isFollower: isFollower,
      source: source,
      lastViewedAt: lastViewedAt ?? this.lastViewedAt,
      viewCount: viewCount ?? this.viewCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory ViewerPivot.fromJson(Map<String, dynamic> json) {
    return ViewerPivot(
      postId: json['post_id'],
      userId: json['user_id'],
      isFollower: Post._toBool(json['is_follower']),
      source: json['source'] ?? '',
      lastViewedAt: Post._toDate(json['last_viewed_at']),
      viewCount: json['view_count'] ?? 0,
      createdAt: Post._toDate(json['created_at']),
      updatedAt: Post._toDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'post_id': postId,
    'user_id': userId,
    'is_follower': isFollower,
    'source': source,
    'last_viewed_at': lastViewedAt?.toIso8601String(),
    'view_count': viewCount,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}

class PostUser {
  final int id;
  final int roleId;
  final String fullName;
  final String email;
  final DateTime? onboardingCompletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserProfile? userProfile;

  PostUser({
    required this.id,
    required this.roleId,
    required this.fullName,
    required this.email,
    this.onboardingCompletedAt,
    this.createdAt,
    this.updatedAt,
    this.userProfile,
  });

  factory PostUser.fromJson(Map<String, dynamic> json) {
    return PostUser(
      id: json['id'],
      roleId: json['role_id'],
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      onboardingCompletedAt: Post._toDate(json['onboarding_completed_at']),
      createdAt: Post._toDate(json['created_at']),
      updatedAt: Post._toDate(json['updated_at']),
      userProfile: json['user_profile'] == null
          ? null
          : UserProfile.fromJson(json['user_profile'] as Map<String, dynamic>),
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
    'user_profile': userProfile?.toJson(),
  };
}

class UserProfile {
  final int userId;
  final String? avatarFullUrl;

  UserProfile({required this.userId, this.avatarFullUrl});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['user_id'],
      avatarFullUrl: json['avatar_full_url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'avatar_full_url': avatarFullUrl,
  };
}
