class GetArchivedPostsModel {
  final bool success;
  final String message;
  final ArchivedPostsData data;

  GetArchivedPostsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetArchivedPostsModel.fromJson(Map<String, dynamic> json) {
    return GetArchivedPostsModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ArchivedPostsData.fromJson(json['data'] ?? {}),
    );
  }
}

class ArchivedPostsData {
  final int currentPage;
  final int lastPage;
  final int total;
  final int perPage;
  final List<DataArchivedPost> posts;

  ArchivedPostsData({
    required this.currentPage,
    required this.lastPage,
    required this.total,
    required this.perPage,
    required this.posts,
  });

  factory ArchivedPostsData.fromJson(Map<String, dynamic> json) {
    return ArchivedPostsData(
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      total: json['total'] ?? 0,
      perPage: json['per_page'] ?? 10,
      posts: (json['data'] as List<dynamic>? ?? [])
          .map((e) => DataArchivedPost.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DataArchivedPost {
  final int id;
  final int userId;
  final String status;
  final String type;
  final String? title;
  final String? content;
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
  final DateTime createdAt;
  final DateTime updatedAt;
  final int likesCount;
  final int commentsCount;
  final int viewsCount;

  DataArchivedPost({
    required this.id,
    required this.userId,
    required this.status,
    required this.type,
    this.title,
    this.content,
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
    required this.createdAt,
    required this.updatedAt,
    required this.likesCount,
    required this.commentsCount,
    required this.viewsCount,
  });

  factory DataArchivedPost.fromJson(Map<String, dynamic> json) {
    bool _toBool(dynamic value) => value == 1 || value == true;

    return DataArchivedPost(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      title: json['title'],
      content: json['content'],
      visibility: json['visibility'] ?? '',
      allowComments: _toBool(json['allow_comments']),
      hideCommentsCount: _toBool(json['hide_comments_count']),
      hideReactions: _toBool(json['hide_reactions']),
      hideReactionsCount: _toBool(json['hide_reactions_count']),
      hideShares: _toBool(json['hide_shares']),
      hideViews: _toBool(json['hide_views']),
      hideViewsCount: _toBool(json['hide_views_count']),
      isEdited: _toBool(json['is_edited']),
      editedAt: json['edited_at'],
      isPinned: _toBool(json['is_pinned']),
      publishedAt: json['published_at'],
      deletedAt: json['deleted_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      likesCount: json['likes_count'] ?? 0,
      commentsCount: json['comments_count'] ?? 0,
      viewsCount: json['views_count'] ?? 0,
    );
  }
}
