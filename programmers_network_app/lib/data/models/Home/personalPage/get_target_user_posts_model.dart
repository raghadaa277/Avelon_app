import 'package:programmers_network_app/data/models/Home/search_post_model.dart';

class GetTargetUserPostsModel {
  final bool success;
  final String message;
  final TargetUserPostsData data;

  GetTargetUserPostsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetTargetUserPostsModel.fromJson(Map<String, dynamic> json) {
    return GetTargetUserPostsModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: TargetUserPostsData.fromJson(json['data'] ?? {}),
    );
  }
}

class TargetUserPostsData {
  final PostPaginatedData posts;

  TargetUserPostsData({required this.posts});

  factory TargetUserPostsData.fromJson(Map<String, dynamic> json) {
    return TargetUserPostsData(
      posts: PostPaginatedData.fromJson(json['posts'] ?? {}),
    );
  }
}

class PostsDataWrapper {
  final PostsPaginatedModel posts;

  PostsDataWrapper({required this.posts});

  factory PostsDataWrapper.fromJson(Map<String, dynamic> json) {
    return PostsDataWrapper(
      posts: PostsPaginatedModel.fromJson(json['posts'] ?? {}),
    );
  }
}

class PostsPaginatedModel {
  final int currentPage;
  final List<PostModel> data;
  final String? firstPageUrl;
  final int from;
  final int lastPage;
  final String? lastPageUrl;
  final List<PageLinkModel> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  PostsPaginatedModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory PostsPaginatedModel.fromJson(Map<String, dynamic> json) {
    return PostsPaginatedModel(
      currentPage: json['current_page'] ?? 1,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstPageUrl: json['first_page_url'],
      from: json['from'] ?? 0,
      lastPage: json['last_page'] ?? 1,
      lastPageUrl: json['last_page_url'],
      links: (json['links'] as List<dynamic>? ?? [])
          .map((e) => PageLinkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPageUrl: json['next_page_url'],
      path: json['path'] ?? '',
      perPage: json['per_page'] ?? 0,
      prevPageUrl: json['prev_page_url'],
      to: json['to'] ?? 0,
      total: json['total'] ?? 0,
    );
  }
}

class PageLinkModel {
  final String? url;
  final String label;
  final int? page;
  final bool active;

  PageLinkModel({
    required this.url,
    required this.label,
    required this.page,
    required this.active,
  });

  factory PageLinkModel.fromJson(Map<String, dynamic> json) {
    return PageLinkModel(
      url: json['url'],
      label: json['label'] ?? '',
      page: json['page'],
      active: json['active'] ?? false,
    );
  }
}

class PostModel {
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
  final String? editedAt;
  final bool isPinned;
  final String? publishedAt;
  final String? deletedAt;
  final int likesCount;
  final int commentsCount;
  final int viewsCount;
  final String? createdAt;
  final String? updatedAt;
  final String? reactionStatus;
  final bool isSaved;
  final bool isViewed;
  final List<PostMediaModel> postMedia;
  final PollModel? poll;
  final List<PostViewerModel> viewers;
  final PostUserModel user;

  PostModel({
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
    required this.editedAt,
    required this.isPinned,
    required this.publishedAt,
    required this.deletedAt,
    required this.likesCount,
    required this.commentsCount,
    required this.viewsCount,
    required this.createdAt,
    required this.updatedAt,
    required this.reactionStatus,
    required this.isSaved,
    required this.isViewed,
    required this.postMedia,
    required this.poll,
    required this.viewers,
    required this.user,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      visibility: json['visibility'] ?? '',
      allowComments: json['allow_comments'] == 1,
      hideCommentsCount: json['hide_comments_count'] == 1,
      hideReactions: json['hide_reactions'] == 1,
      hideReactionsCount: json['hide_reactions_count'] == 1,
      hideShares: json['hide_shares'] == 1,
      hideViews: json['hide_views'] == 1,
      hideViewsCount: json['hide_views_count'] == 1,
      isEdited: json['is_edited'] == 1,
      editedAt: json['edited_at'],
      isPinned: json['is_pinned'] == 1,
      publishedAt: json['published_at'],
      deletedAt: json['deleted_at'],
      likesCount: json['likes_count'] ?? 0,
      commentsCount: json['comments_count'] ?? 0,
      viewsCount: json['views_count'] ?? 0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      reactionStatus: json['reaction_status'],
      isSaved: json['is_saved'] == 1,
      isViewed: json['is_viewed'] == 1,
      postMedia: (json['post_media'] as List<dynamic>? ?? [])
          .map((e) => PostMediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      poll: json['poll'] != null
          ? PollModel.fromJson(json['poll'] as Map<String, dynamic>)
          : null,
      viewers: (json['viewers'] as List<dynamic>? ?? [])
          .map((e) => PostViewerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: PostUserModel.fromJson(json['user'] ?? {}),
    );
  }
}

class PostMediaModel {
  final int id;
  final int postId;
  final String mimeType;
  final int size;
  final int width;
  final int height;
  final int order;
  final String status;
  final String? errorMessage;
  final String? createdAt;
  final String? updatedAt;
  final String mediaFullUrl;

  PostMediaModel({
    required this.id,
    required this.postId,
    required this.mimeType,
    required this.size,
    required this.width,
    required this.height,
    required this.order,
    required this.status,
    required this.errorMessage,
    required this.createdAt,
    required this.updatedAt,
    required this.mediaFullUrl,
  });

  factory PostMediaModel.fromJson(Map<String, dynamic> json) {
    return PostMediaModel(
      id: json['id'] ?? 0,
      postId: json['post_id'] ?? 0,
      mimeType: json['mime_type'] ?? '',
      size: json['size'] ?? 0,
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      order: json['order'] ?? 0,
      status: json['status'] ?? '',
      errorMessage: json['error_message'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      mediaFullUrl: json['media_full_url'] ?? '',
    );
  }
}

class PollModel {
  final int id;
  final int postId;
  final String question;
  final bool allowMultipleAnswers;
  final String? expiresAt;
  final String? createdAt;
  final String? updatedAt;
  final List<PollOptionModel> pollOptions;

  PollModel({
    required this.id,
    required this.postId,
    required this.question,
    required this.allowMultipleAnswers,
    required this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
    required this.pollOptions,
  });

  factory PollModel.fromJson(Map<String, dynamic> json) {
    return PollModel(
      id: json['id'] ?? 0,
      postId: json['post_id'] ?? 0,
      question: json['question'] ?? '',
      allowMultipleAnswers: json['allow_multiple_answers'] == 1,
      expiresAt: json['expires_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      pollOptions: (json['poll_options'] as List<dynamic>? ?? [])
          .map((e) => PollOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class PollOptionModel {
  final int id;
  final int pollId;
  final String option;
  final int voteCount;
  final String? createdAt;
  final String? updatedAt;
  final List<dynamic> voters;

  PollOptionModel({
    required this.id,
    required this.pollId,
    required this.option,
    required this.voteCount,
    required this.createdAt,
    required this.updatedAt,
    required this.voters,
  });

  factory PollOptionModel.fromJson(Map<String, dynamic> json) {
    return PollOptionModel(
      id: json['id'] ?? 0,
      pollId: json['poll_id'] ?? 0,
      option: json['option'] ?? '',
      voteCount: json['vote_count'] ?? 0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      voters: json['voters'] ?? [],
    );
  }
}

class PostViewerModel {
  final int id;
  final int roleId;
  final String fullName;
  final String email;
  final String? onboardingCompletedAt;
  final String? createdAt;
  final String? updatedAt;
  final ViewerPivotModel pivot;

  PostViewerModel({
    required this.id,
    required this.roleId,
    required this.fullName,
    required this.email,
    required this.onboardingCompletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory PostViewerModel.fromJson(Map<String, dynamic> json) {
    return PostViewerModel(
      id: json['id'] ?? 0,
      roleId: json['role_id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      onboardingCompletedAt: json['onboarding_completed_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      pivot: ViewerPivotModel.fromJson(json['pivot'] ?? {}),
    );
  }
}

class ViewerPivotModel {
  final int postId;
  final int userId;
  final bool isFollower;
  final String source;
  final String? lastViewedAt;
  final int viewCount;
  final String? createdAt;
  final String? updatedAt;

  ViewerPivotModel({
    required this.postId,
    required this.userId,
    required this.isFollower,
    required this.source,
    required this.lastViewedAt,
    required this.viewCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ViewerPivotModel.fromJson(Map<String, dynamic> json) {
    return ViewerPivotModel(
      postId: json['post_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      isFollower: json['is_follower'] == 1,
      source: json['source'] ?? '',
      lastViewedAt: json['last_viewed_at'],
      viewCount: json['view_count'] ?? 0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class PostUserModel {
  final int id;
  final int roleId;
  final String fullName;
  final String email;
  final String? onboardingCompletedAt;
  final String? createdAt;
  final String? updatedAt;
  final PostUserProfileModel userProfile;

  PostUserModel({
    required this.id,
    required this.roleId,
    required this.fullName,
    required this.email,
    required this.onboardingCompletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.userProfile,
  });

  factory PostUserModel.fromJson(Map<String, dynamic> json) {
    return PostUserModel(
      id: json['id'] ?? 0,
      roleId: json['role_id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      onboardingCompletedAt: json['onboarding_completed_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userProfile: PostUserProfileModel.fromJson(json['user_profile'] ?? {}),
    );
  }
}

class PostUserProfileModel {
  final int userId;
  final String? avatarFullUrl;

  PostUserProfileModel({required this.userId, required this.avatarFullUrl});

  factory PostUserProfileModel.fromJson(Map<String, dynamic> json) {
    return PostUserProfileModel(
      userId: json['user_id'] ?? 0,
      avatarFullUrl: json['avatar_full_url'],
    );
  }
}
