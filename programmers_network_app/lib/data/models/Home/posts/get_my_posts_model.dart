import 'package:programmers_network_app/data/models/Home/search_post_model.dart';
import 'package:programmers_network_app/data/models/Profile/profile_model.dart';

class GetMyPostsModel {
  final bool success;
  final String message;
  final PostsPaginationModel data;

  GetMyPostsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetMyPostsModel.fromJson(Map<String, dynamic> json) {
    return GetMyPostsModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: PostsPaginationModel.fromJson(json['data']),
    );
  }
}

class PostsPaginationModel {
  final int currentPage;
  final int lastPage;
  final int total;
  final int perPage;
  final String? nextPageUrl;
  final String? prevPageUrl;
  final List<PostModel> posts;

  PostsPaginationModel({
    required this.currentPage,
    required this.lastPage,
    required this.total,
    required this.perPage,
    this.nextPageUrl,
    this.prevPageUrl,
    required this.posts,
  });

  factory PostsPaginationModel.fromJson(Map<String, dynamic> json) {
    return PostsPaginationModel(
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      total: json['total'] ?? 0,
      perPage: json['per_page'] ?? 5,
      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'],
      posts: (json['data'] as List<dynamic>? ?? [])
          .map((e) => PostModel.fromJson(e))
          .toList(),
    );
  }
}

class PostModel {
  final String createdAt;
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
  final bool hideShares; // جديد
  final bool hideViews;
  final bool hideViewsCount;
  final bool isEdited;
  final bool isSave;
  bool isPinned;
  final String? publishedAt;
  final int likesCount;
  final int disLikesCount; // جديد
  final int commentsCount;
  final int viewsCount;
  final List<PostMediaModel> postMedia;
  final PollModel? poll;
  final String? reactionStatus;

  final ProfileData? profileData;

  PostModel({
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
    required this.isPinned,
    this.publishedAt,
    required this.likesCount,
    required this.disLikesCount,
    required this.commentsCount,
    required this.viewsCount,
    required this.postMedia,
    required this.createdAt,
    this.poll,
    this.profileData,
    this.reactionStatus,
    required this.isSave,
  });

  static bool _toBool(dynamic v) => v == true || v == 1 || v == '1';

  /// يطبّع reaction_status: "nolike" أو فاضي أو null بترجع null فعلياً
  /// (نفس منطق Post.fromJson تبع الـ search model، حتى يكون التصرف موحّد)
  static String? _normalizeReactionStatus(dynamic v) {
    final status = v?.toString();
    if (status == null ||
        status.isEmpty ||
        status == 'null' ||
        status == 'nolike') {
      return null;
    }
    return status;
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      title: json['title'],
      content: json['content'],
      visibility: json['visibility'] ?? 'public',
      allowComments: _toBool(json['allow_comments']),
      hideCommentsCount: _toBool(json['hide_comments_count']),
      hideReactions: _toBool(json['hide_reactions']),
      hideReactionsCount: _toBool(json['hide_reactions_count']),
      hideShares: _toBool(json['hide_shares']), // جديد
      hideViews: _toBool(json['hide_views']),
      hideViewsCount: _toBool(json['hide_views_count']),
      isEdited: _toBool(json['is_edited']),
      isPinned: _toBool(json['is_pinned']),
      publishedAt: json['published_at'],
      likesCount: json['likes_count'] ?? 0,
      disLikesCount: json['dislikes_count'] ?? 0, // جديد
      commentsCount: json['comments_count'] ?? 0,
      viewsCount: json['views_count'] ?? 0,
      reactionStatus: _normalizeReactionStatus(json['reaction_status']),
      isSave: _toBool(json['is_saved']),

      postMedia: (json['post_media'] as List<dynamic>? ?? [])
          .map((e) => PostMediaModel.fromJson(e))
          .toList(),

      poll: json['poll'] != null ? PollModel.fromJson(json['poll']) : null,

      createdAt: json['created_at'] ?? '',

      profileData: json['user'] != null
          ? ProfileData.fromJson({
              ...json['user'],
              ...?json['user']['user_profile'],
              'user_id': json['user']['id'],
            })
          : null,
    );
  }

  PostModel copyWith({
    int? likesCount,
    int? disLikesCount,
    String reactionStatus = _notSetSentinel,
    bool? isSave,
  }) {
    return PostModel(
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
      isPinned: isPinned,
      publishedAt: publishedAt,
      likesCount: likesCount ?? this.likesCount,
      disLikesCount: disLikesCount ?? this.disLikesCount,
      commentsCount: commentsCount,
      viewsCount: viewsCount,
      postMedia: postMedia,
      createdAt: createdAt,
      poll: poll,
      profileData: profileData,
      isSave: isSave ?? this.isSave,
      reactionStatus: reactionStatus == _notSetSentinel
          ? this.reactionStatus
          : (reactionStatus.isEmpty ? null : reactionStatus),
    );
  }
}

const String _notSetSentinel = '__NOT_SET_SENTINEL__';

class PostMediaModel {
  final int id;
  final String mimeType;
  final int size;
  final int width;
  final int height;
  final String mediaFullUrl;

  PostMediaModel({
    required this.id,
    required this.mimeType,
    required this.size,
    required this.width,
    required this.height,
    required this.mediaFullUrl,
  });

  factory PostMediaModel.fromJson(Map<String, dynamic> json) {
    return PostMediaModel(
      id: json['id'] ?? 0,
      mimeType: json['mime_type'] ?? '',
      size: json['size'] ?? 0,
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      mediaFullUrl: json['media_full_url'] ?? '',
    );
  }
}

class PollModel {
  final int id;
  final String question;
  final bool allowMultipleAnswers;
  final String? expiresAt;
  final List<PollOptionModel> pollOptions;

  PollModel({
    required this.id,
    required this.question,
    required this.allowMultipleAnswers,
    this.expiresAt,
    required this.pollOptions,
  });

  factory PollModel.fromJson(Map<String, dynamic> json) {
    return PollModel(
      id: json['id'] ?? 0,
      question: json['question'] ?? '',
      allowMultipleAnswers: (json['allow_multiple_answers'] ?? 0) == 1,
      expiresAt: json['expires_at'],
      pollOptions: (json['poll_options'] as List<dynamic>? ?? [])
          .map((e) => PollOptionModel.fromJson(e))
          .toList(),
    );
  }
}

class PollOptionModel {
  final int id;
  final String option;
  final int voteCount;

  PollOptionModel({
    required this.id,
    required this.option,
    required this.voteCount,
  });

  factory PollOptionModel.fromJson(Map<String, dynamic> json) {
    return PollOptionModel(
      id: json['id'] ?? 0,
      option: json['option'] ?? '',
      voteCount: json['vote_count'] ?? 0,
    );
  }
}

extension PostModelMapper on PostModel {
  Post toSearchPost() {
    return Post(
      id: id,
      userId: userId,
      status: status,
      type: type,
      title: title ?? '',
      content: content ?? '',
      visibility: visibility,
      allowComments: allowComments,
      hideCommentsCount: hideCommentsCount,
      hideReactions: hideReactions,
      hideReactionsCount: hideReactionsCount,
      hideShares: hideShares, // ✅ صار حقيقي بدل false ثابتة
      hideViews: hideViews,
      hideViewsCount: hideViewsCount,
      isEdited: isEdited,
      editedAt: null,
      isPinned: isPinned,
      publishedAt: publishedAt != null ? DateTime.tryParse(publishedAt!) : null,
      deletedAt: null,
      likesCount: likesCount,
      disLikesCount: disLikesCount, // ✅ صار حقيقي بدل 0 ثابتة
      commentsCount: commentsCount,
      viewsCount: viewsCount,
      createdAt: DateTime.tryParse(createdAt),
      updatedAt: null,
      followingOrder: null,
      searchOrder: null,
      reactionStatus: reactionStatus,
      isSaved: isSave,
      isViewed: false,
      followStatus: null,
      postMedia: postMedia
          .map(
            (m) => PostMedia(
              id: m.id,
              postId: id,
              mimeType: m.mimeType,
              size: m.size,
              width: m.width,
              height: m.height,
              order: 0,
              status: 'completed',
              mediaFullUrl: m.mediaFullUrl,
            ),
          )
          .toList(),
      poll: poll == null
          ? null
          : Poll(
              id: poll!.id,
              postId: id,
              question: poll!.question,
              options: poll!.pollOptions
                  .map(
                    (o) => {
                      'id': o.id,
                      'option': o.option,
                      'vote_count': o.voteCount,
                    },
                  )
                  .toList(),
              expiresAt: null,
            ),
      viewers: const [],
      user: profileData == null
          ? PostUser(id: userId, roleId: 0, fullName: '', email: '')
          : PostUser(
              id: profileData!.userId,
              roleId: 0,
              fullName: profileData!.fullName,
              email: '',
              userProfile: UserProfile(
                userId: profileData!.userId,
                avatarFullUrl: profileData!.avatarFullUrl,
              ),
            ),
      feedId: null,
    );
  }
}

// import 'package:programmers_network_app/data/models/Home/search_post_model.dart';
// import 'package:programmers_network_app/data/models/Profile/profile_model.dart';

// class GetMyPostsModel {
//   final bool success;
//   final String message;
//   final PostsPaginationModel data;

//   GetMyPostsModel({
//     required this.success,
//     required this.message,
//     required this.data,
//   });

//   factory GetMyPostsModel.fromJson(Map<String, dynamic> json) {
//     return GetMyPostsModel(
//       success: json['success'] ?? false,
//       message: json['message'] ?? '',
//       data: PostsPaginationModel.fromJson(json['data']),
//     );
//   }
// }

// class PostsPaginationModel {
//   final int currentPage;
//   final int lastPage;
//   final int total;
//   final int perPage;
//   final String? nextPageUrl;
//   final String? prevPageUrl;
//   final List<PostModel> posts;

//   PostsPaginationModel({
//     required this.currentPage,
//     required this.lastPage,
//     required this.total,
//     required this.perPage,
//     this.nextPageUrl,
//     this.prevPageUrl,
//     required this.posts,
//   });

//   factory PostsPaginationModel.fromJson(Map<String, dynamic> json) {
//     return PostsPaginationModel(
//       currentPage: json['current_page'] ?? 1,
//       lastPage: json['last_page'] ?? 1,
//       total: json['total'] ?? 0,
//       perPage: json['per_page'] ?? 5,
//       nextPageUrl: json['next_page_url'],
//       prevPageUrl: json['prev_page_url'],
//       posts: (json['data'] as List<dynamic>? ?? [])
//           .map((e) => PostModel.fromJson(e))
//           .toList(),
//     );
//   }
// }

// // class PostModel {
// //   final String createdAt;
// //   final int id;
// //   final int userId;
// //   final String status;
// //   final String type;
// //   final String? title;
// //   final String? content;
// //   final String visibility;
// //   final bool allowComments;
// //   final bool hideCommentsCount;
// //   final bool hideReactions;
// //   final bool hideReactionsCount;
// //   final bool hideViews;
// //   final bool hideViewsCount;
// //   final bool isEdited;
// //   bool isPinned;
// //   final String? publishedAt;
// //   final int likesCount;
// //   final int commentsCount;
// //   final int viewsCount;
// //   final List<PostMediaModel> postMedia;
// //   final PollModel? poll;

// //   PostModel({
// //     required this.id,
// //     required this.userId,
// //     required this.status,
// //     required this.type,
// //     this.title,
// //     this.content,
// //     required this.visibility,
// //     required this.allowComments,
// //     required this.hideCommentsCount,
// //     required this.hideReactions,
// //     required this.hideReactionsCount,
// //     required this.hideViews,
// //     required this.hideViewsCount,
// //     required this.isEdited,
// //     required this.isPinned,
// //     this.publishedAt,
// //     required this.likesCount,
// //     required this.commentsCount,
// //     required this.viewsCount,
// //     required this.postMedia,
// //     required this.createdAt,
// //     this.poll,
// //   });

// //   factory PostModel.fromJson(Map<String, dynamic> json) {
// //     return PostModel(
// //       id: json['id'] ?? 0,
// //       userId: json['user_id'] ?? 0,
// //       status: json['status'] ?? '',
// //       type: json['type'] ?? '',
// //       title: json['title'],
// //       content: json['content'],
// //       visibility: json['visibility'] ?? 'public',
// //       allowComments: (json['allow_comments'] ?? 0) == 1,
// //       hideCommentsCount: (json['hide_comments_count'] ?? 0) == 1,
// //       hideReactions: (json['hide_reactions'] ?? 0) == 1,
// //       hideReactionsCount: (json['hide_reactions_count'] ?? 0) == 1,
// //       hideViews: (json['hide_views'] ?? 0) == 1,
// //       hideViewsCount: (json['hide_views_count'] ?? 0) == 1,
// //       isEdited: (json['is_edited'] ?? 0) == 1,
// //       isPinned: (json['is_pinned'] ?? 0) == 1,
// //       publishedAt: json['published_at'],
// //       likesCount: json['likes_count'] ?? 0,
// //       commentsCount: json['comments_count'] ?? 0,
// //       viewsCount: json['views_count'] ?? 0,
// //       postMedia: (json['post_media'] as List<dynamic>? ?? [])
// //           .map((e) => PostMediaModel.fromJson(e))
// //           .toList(),
// //       poll: json['poll'] != null ? PollModel.fromJson(json['poll']) : null,
// //       createdAt: json['created_at'] ?? '',
// //     );
// //   }
// // }
// class PostModel {
//   final String createdAt;
//   final int id;
//   final int userId;
//   final String status;
//   final String type;
//   final String? title;
//   final String? content;
//   final String visibility;
//   final bool allowComments;
//   final bool hideCommentsCount;
//   final bool hideReactions;
//   final bool hideReactionsCount;
//   final bool hideViews;
//   final bool hideViewsCount;
//   final bool isEdited;
//   final bool isSave;
//   bool isPinned;
//   final String? publishedAt;
//   final int likesCount;
//   final int commentsCount;
//   final int viewsCount;
//   final List<PostMediaModel> postMedia;
//   final PollModel? poll;
//   final String? reactionStatus;

//   final ProfileData? profileData;

//   PostModel({
//     required this.id,
//     required this.userId,
//     required this.status,
//     required this.type,
//     this.title,
//     this.content,
//     required this.visibility,
//     required this.allowComments,
//     required this.hideCommentsCount,
//     required this.hideReactions,
//     required this.hideReactionsCount,
//     required this.hideViews,
//     required this.hideViewsCount,
//     required this.isEdited,
//     required this.isPinned,
//     this.publishedAt,
//     required this.likesCount,
//     required this.commentsCount,
//     required this.viewsCount,
//     required this.postMedia,
//     required this.createdAt,
//     this.poll,
//     this.profileData,
//     this.reactionStatus,
//     required this.isSave,
//   });

//   static bool _toBool(dynamic v) => v == true || v == 1 || v == '1';

//   factory PostModel.fromJson(Map<String, dynamic> json) {
//     return PostModel(
//       id: json['id'] ?? 0,
//       userId: json['user_id'] ?? 0,
//       status: json['status'] ?? '',
//       type: json['type'] ?? '',
//       title: json['title'],
//       content: json['content'],
//       visibility: json['visibility'] ?? 'public',
//       allowComments: _toBool(json['allow_comments']),
//       hideCommentsCount: _toBool(json['hide_comments_count']),
//       hideReactions: _toBool(json['hide_reactions']),
//       hideReactionsCount: _toBool(json['hide_reactions_count']),
//       hideViews: _toBool(json['hide_views']),
//       hideViewsCount: _toBool(json['hide_views_count']),
//       isEdited: _toBool(json['is_edited']),
//       isPinned: _toBool(json['is_pinned']),
//       publishedAt: json['published_at'],
//       likesCount: json['likes_count'] ?? 0,
//       commentsCount: json['comments_count'] ?? 0,
//       viewsCount: json['views_count'] ?? 0,
//       reactionStatus: json['reaction_status'],
//       isSave: _toBool(json['is_saved']), // ✅ الإصلاح هون

//       postMedia: (json['post_media'] as List<dynamic>? ?? [])
//           .map((e) => PostMediaModel.fromJson(e))
//           .toList(),

//       poll: json['poll'] != null ? PollModel.fromJson(json['poll']) : null,

//       createdAt: json['created_at'] ?? '',

//       profileData: json['user'] != null
//           ? ProfileData.fromJson({
//               ...json['user'],
//               ...?json['user']['user_profile'],
//               'user_id': json['user']['id'],
//             })
//           : null,
//     );
//   }

//   PostModel copyWith({int? likesCount, String? reactionStatus}) {
//     return PostModel(
//       id: id,
//       userId: userId,
//       status: status,
//       type: type,
//       title: title,
//       content: content,
//       visibility: visibility,
//       allowComments: allowComments,
//       hideCommentsCount: hideCommentsCount,
//       hideReactions: hideReactions,
//       hideReactionsCount: hideReactionsCount,
//       hideViews: hideViews,
//       hideViewsCount: hideViewsCount,
//       isEdited: isEdited,
//       isPinned: isPinned,
//       publishedAt: publishedAt,
//       likesCount: likesCount ?? this.likesCount,
//       commentsCount: commentsCount,
//       viewsCount: viewsCount,
//       postMedia: postMedia,
//       createdAt: createdAt,
//       poll: poll,
//       profileData: profileData,
//       isSave: isSave,
//       reactionStatus: reactionStatus ?? this.reactionStatus,
//     );
//   }
// }

// class PostMediaModel {
//   final int id;
//   final String mimeType;
//   final int size;
//   final int width;
//   final int height;
//   final String mediaFullUrl;

//   PostMediaModel({
//     required this.id,
//     required this.mimeType,
//     required this.size,
//     required this.width,
//     required this.height,
//     required this.mediaFullUrl,
//   });

//   factory PostMediaModel.fromJson(Map<String, dynamic> json) {
//     return PostMediaModel(
//       id: json['id'] ?? 0,
//       mimeType: json['mime_type'] ?? '',
//       size: json['size'] ?? 0,
//       width: json['width'] ?? 0,
//       height: json['height'] ?? 0,
//       mediaFullUrl: json['media_full_url'] ?? '',
//     );
//   }
// }

// class PollModel {
//   final int id;
//   final String question;
//   final bool allowMultipleAnswers;
//   final String? expiresAt;
//   final List<PollOptionModel> pollOptions;

//   PollModel({
//     required this.id,
//     required this.question,
//     required this.allowMultipleAnswers,
//     this.expiresAt,
//     required this.pollOptions,
//   });

//   factory PollModel.fromJson(Map<String, dynamic> json) {
//     return PollModel(
//       id: json['id'] ?? 0,
//       question: json['question'] ?? '',
//       allowMultipleAnswers: (json['allow_multiple_answers'] ?? 0) == 1,
//       expiresAt: json['expires_at'],
//       pollOptions: (json['poll_options'] as List<dynamic>? ?? [])
//           .map((e) => PollOptionModel.fromJson(e))
//           .toList(),
//     );
//   }
// }

// class PollOptionModel {
//   final int id;
//   final String option;
//   final int voteCount;

//   PollOptionModel({
//     required this.id,
//     required this.option,
//     required this.voteCount,
//   });

//   factory PollOptionModel.fromJson(Map<String, dynamic> json) {
//     return PollOptionModel(
//       id: json['id'] ?? 0,
//       option: json['option'] ?? '',
//       voteCount: json['vote_count'] ?? 0,
//     );
//   }
// }

// extension PostModelMapper on PostModel {
//   Post toSearchPost() {
//     return Post(
//       id: id,
//       userId: userId,
//       status: status,
//       type: type,
//       title: title ?? '',
//       content: content ?? '',
//       visibility: visibility,
//       allowComments: allowComments,
//       hideCommentsCount: hideCommentsCount,
//       hideReactions: hideReactions,
//       hideReactionsCount: hideReactionsCount,
//       hideShares: false,
//       hideViews: hideViews,
//       hideViewsCount: hideViewsCount,
//       isEdited: isEdited,
//       editedAt: null,
//       isPinned: isPinned,
//       publishedAt: publishedAt != null ? DateTime.tryParse(publishedAt!) : null,
//       deletedAt: null,
//       likesCount: likesCount,
//       disLikesCount: 0,
//       commentsCount: commentsCount,
//       viewsCount: viewsCount,
//       createdAt: DateTime.tryParse(createdAt),
//       updatedAt: null,
//       followingOrder: null,
//       searchOrder: null,
//       reactionStatus: reactionStatus,
//       isSaved: isSave,
//       isViewed: false,
//       followStatus: null,
//       postMedia: postMedia
//           .map(
//             (m) => PostMedia(
//               id: m.id,
//               postId: id,
//               mimeType: m.mimeType,
//               size: m.size,
//               width: m.width,
//               height: m.height,
//               order: 0,
//               status: 'completed',
//               mediaFullUrl: m.mediaFullUrl,
//             ),
//           )
//           .toList(),
//       poll: poll == null
//           ? null
//           : Poll(
//               id: poll!.id,
//               postId: id,
//               question: poll!.question,
//               options: poll!.pollOptions
//                   .map(
//                     (o) => {
//                       'id': o.id,
//                       'option': o.option,
//                       'vote_count': o.voteCount,
//                     },
//                   )
//                   .toList(),
//               expiresAt: null,
//             ),
//       viewers: const [],
//       user: profileData == null
//           ? PostUser(id: userId, roleId: 0, fullName: '', email: '')
//           : PostUser(
//               id: profileData!.userId,
//               roleId: 0,
//               fullName: profileData!.fullName,
//               email: '',
//               userProfile: UserProfile(
//                 userId: profileData!.userId,
//                 avatarFullUrl: profileData!.avatarFullUrl,
//               ),
//             ),
//       feedId: null,
//     );
//   }
// }
