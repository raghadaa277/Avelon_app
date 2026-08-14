import 'package:programmers_network_app/data/models/Home/posts/comments/get_post_comments_model.dart';
import 'package:programmers_network_app/data/models/Profile/profile_model.dart';

import 'package:programmers_network_app/data/services/Home/posts/comments/comments_services.dart';
import 'package:get/get.dart';

class CommentsController extends GetxController {
  final CommentsServices _commentsServices = CommentsServices();

  bool isLoading = false;
  final RxString errorMessage = ''.obs;
  ProfileData? currentUser;

  List<DataPostComments> comments = [];
  bool isLoadingMore = false;
  int currentPage = 1;
  int lastPage = 1;
  int total = 0;
  int? currentTarget;
  int? currentPostId;
  bool isMyPost = false;

  final Map<int, List<DataPostComments>> repliesMap = {};
  final Map<int, bool> repliesLoadingMap = {};
  final Map<int, String> repliesErrorMap = {};
  final Set<int> expandedReplies = {};

  final Map<int, int> repliesCurrentPage = {};
  final Map<int, int> repliesLastPage = {};
  final Map<int, int> repliesTotal = {};
  final Map<int, bool> repliesLoadingMoreMap = {};

  Future<void> getPostComments({
    required int targetUserId,
    required int postId,
    bool refresh = true,
  }) async {
    if (isLoading) return;
    if (refresh) {
      currentPage = 1;
      comments.clear();
    }

    currentTarget = targetUserId;
    currentPostId = postId;

    isLoading = true;
    errorMessage.value = '';
    update();

    try {
      final result = await _commentsServices.getPostComment(
        targetUserId: targetUserId,
        postId: postId,
        page: currentPage,
      );

      if (result.success) {
        comments.addAll(result.comments.data);
        lastPage = result.comments.lastPage;
        total = result.comments.total;
        isMyPost = result.isMyPost;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore || isLoading) return;
    if (currentPage >= lastPage) return;
    if (currentTarget == null || currentPostId == null) return;

    isLoadingMore = true;
    update();

    currentPage++;

    try {
      final result = await _commentsServices.getPostComment(
        targetUserId: currentTarget!,
        postId: currentPostId!,
        page: currentPage,
      );

      if (result.success) {
        comments.addAll(result.comments.data);
        lastPage = result.comments.lastPage;
        total = result.comments.total;
      }
    } catch (e) {
      currentPage--;
      errorMessage.value = e.toString();
    } finally {
      isLoadingMore = false;
      update();
    }
  }

  void updateReaction({required int commentId, required String reaction}) {
    DataPostComments? comment;
    int? index;
    List<DataPostComments>? targetList;

    index = comments.indexWhere((c) => c.id == commentId);
    if (index != -1) {
      targetList = comments;
      comment = comments[index];
    } else {
      for (final entry in repliesMap.entries) {
        final i = entry.value.indexWhere((c) => c.id == commentId);

        if (i != -1) {
          targetList = entry.value;
          index = i;
          comment = entry.value[i];
          break;
        }
      }
    }

    if (comment == null || targetList == null || index == null) return;

    final wasLiked = comment.reactionStatus == 'like';
    final wasDisliked = comment.reactionStatus == 'dislike';

    int likes = comment.likesCount;
    int dislikes = comment.disLikesCount;
    String newStatus;

    if (reaction == 'like') {
      if (wasLiked) {
        likes--;
        newStatus = '';
      } else {
        likes++;
        if (wasDisliked) dislikes--;
        newStatus = 'like';
      }
    } else {
      if (wasDisliked) {
        dislikes--;
        newStatus = '';
      } else {
        dislikes++;
        if (wasLiked) likes--;
        newStatus = 'dislike';
      }
    }

    targetList[index] = comment.copyWith(
      reactionStatus: newStatus,
      likesCount: likes < 0 ? 0 : likes,
      disLikesCount: dislikes < 0 ? 0 : dislikes,
    );

    update();
  }

  void updateCommentContent({required int commentId, required String content}) {
    DataPostComments? comment;
    int? index;
    List<DataPostComments>? targetList;

    index = comments.indexWhere((c) => c.id == commentId);
    if (index != -1) {
      targetList = comments;
      comment = comments[index];
    } else {
      for (final entry in repliesMap.entries) {
        final i = entry.value.indexWhere((c) => c.id == commentId);

        if (i != -1) {
          targetList = entry.value;
          index = i;
          comment = entry.value[i];
          break;
        }
      }
    }

    if (comment == null || targetList == null || index == null) return;

    targetList[index] = comment.copyWith(content: content);

    update();
  }

  /// دالة عامة تدور على الكومنت (بالـ comments الرئيسية أو جوا الـ replies)
  /// وبتطبّق التعديل عليه. مستخدمة لتحديث isPinned/isBest محلياً بعد نجاح الـ API.
  void _updateCommentInPlace(
    int commentId,
    DataPostComments Function(DataPostComments) transform,
  ) {
    final index = comments.indexWhere((c) => c.id == commentId);
    if (index != -1) {
      comments[index] = transform(comments[index]);
      update();
      return;
    }

    for (final entry in repliesMap.entries) {
      final i = entry.value.indexWhere((c) => c.id == commentId);
      if (i != -1) {
        entry.value[i] = transform(entry.value[i]);
        update();
        return;
      }
    }
  }

  void updatePinStatus({required int commentId, required bool isPinned}) {
    _updateCommentInPlace(commentId, (c) => c.copyWith(isPinned: isPinned));
  }

  void updateBestStatus({required int commentId, required bool isBest}) {
    _updateCommentInPlace(commentId, (c) => c.copyWith(isBest: isBest));
  }

  Future<bool> manageDeleteComment({
    required int postId,
    required int commentId,
  }) async {
    final success = await _manage(
      postId: postId,
      commentId: commentId,
      action: 'delete',
    );

    if (success) {
      removeCommentById(commentId);
    }

    return success;
  }

  Future<void> reactToComment({
    required int targetUserId,
    required int postId,
    required int commentId,
    required String type,
  }) async {
    updateReaction(commentId: commentId, reaction: type);

    try {
      final result = await _commentsServices.reactionsComment(
        targetUserId: targetUserId,
        postId: postId,
        commentId: commentId,
        type: type,
      );

      if (!result.success) {
        await getPostComments(
          targetUserId: targetUserId,
          postId: postId,
          refresh: true,
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();

      await getPostComments(
        targetUserId: targetUserId,
        postId: postId,
        refresh: true,
      );
    }
  }

  List<DataPostComments> get sortedComments {
    final pinned = comments.where((c) => c.isPinned).toList();
    final others = comments.where((c) => !c.isPinned).toList();
    return [...pinned, ...others];
  }

  List<DataPostComments> repliesOf(int commentId) =>
      repliesMap[commentId] ?? [];

  bool isLoadingRepliesOf(int commentId) =>
      repliesLoadingMap[commentId] ?? false;

  bool isRepliesExpanded(int commentId) => expandedReplies.contains(commentId);

  Future<void> loadReplies({
    required int targetUserId,
    required int postId,
    required int commentId,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh && repliesMap.containsKey(commentId)) return;
    if (repliesLoadingMap[commentId] == true) return;

    repliesLoadingMap[commentId] = true;
    repliesErrorMap.remove(commentId);
    update();

    try {
      final result = await _commentsServices.getCommentReplies(
        targetUserId: targetUserId,
        postId: postId,
        commentId: commentId,
        page: 1,
      );

      if (result.success) {
        repliesMap[commentId] = result.replies.data;
        repliesCurrentPage[commentId] = 1;
        repliesLastPage[commentId] = result.replies.lastPage;
        repliesTotal[commentId] = result.replies.total;
      }
    } catch (e) {
      repliesErrorMap[commentId] = e.toString();
    } finally {
      repliesLoadingMap[commentId] = false;
      update();
    }
  }

  bool hasMoreReplies(int commentId) {
    final current = repliesCurrentPage[commentId] ?? 1;
    final last = repliesLastPage[commentId] ?? 1;
    return current < last;
  }

  bool isLoadingMoreRepliesOf(int commentId) =>
      repliesLoadingMoreMap[commentId] ?? false;

  Future<void> loadMoreReplies({
    required int targetUserId,
    required int postId,
    required int commentId,
  }) async {
    if (repliesLoadingMoreMap[commentId] == true) return;
    if (repliesLoadingMap[commentId] == true) return;
    if (!hasMoreReplies(commentId)) return;

    repliesLoadingMoreMap[commentId] = true;
    update();

    final nextPage = (repliesCurrentPage[commentId] ?? 1) + 1;

    try {
      final result = await _commentsServices.getCommentReplies(
        targetUserId: targetUserId,
        postId: postId,
        commentId: commentId,
        page: nextPage,
      );

      if (result.success) {
        final existing = repliesMap[commentId] ?? [];
        final existingIds = existing.map((c) => c.id).toSet();
        final newOnes = result.replies.data
            .where((c) => !existingIds.contains(c.id))
            .toList();

        repliesMap[commentId] = [...existing, ...newOnes];
        repliesCurrentPage[commentId] = nextPage;
        repliesLastPage[commentId] = result.replies.lastPage;
        repliesTotal[commentId] = result.replies.total;
      }
    } catch (e) {
      repliesErrorMap[commentId] = e.toString();
    } finally {
      repliesLoadingMoreMap[commentId] = false;
      update();
    }
  }

  Future<void> toggleReplies({
    required int targetUserId,
    required int postId,
    required int commentId,
  }) async {
    if (expandedReplies.contains(commentId)) {
      expandedReplies.remove(commentId);
      update();
      return;
    }

    expandedReplies.add(commentId);
    update();

    if (!repliesMap.containsKey(commentId)) {
      await loadReplies(
        targetUserId: targetUserId,
        postId: postId,
        commentId: commentId,
      );
    }
  }

  bool isSubmittingComment = false;

  Future<bool> createComment({
    required int targetUserId,
    required int postId,
    required String content,
    int? parentId,
  }) async {
    final trimmed = content.trim();
    if (trimmed.isEmpty) return false;

    isSubmittingComment = true;
    update();

    try {
      final result = await _commentsServices.createComment(
        targetUserId: targetUserId,
        postId: postId,
        parentId: parentId,
        content: trimmed,
      );

      if (result.success) {
        if (parentId == null) {
          await _prependLatestComment(
            targetUserId: targetUserId,
            postId: postId,
          );
        } else {
          await _prependLatestReply(
            targetUserId: targetUserId,
            postId: postId,
            parentId: parentId,
          );
        }
        return true;
      }
      return false;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    } finally {
      isSubmittingComment = false;
      update();
    }
  }

  Future<void> _prependLatestComment({
    required int targetUserId,
    required int postId,
  }) async {
    try {
      final result = await _commentsServices.getPostComment(
        targetUserId: targetUserId,
        postId: postId,
        page: 1,
      );

      if (result.success) {
        final existingIds = comments.map((c) => c.id).toSet();
        final newOnes = result.comments.data
            .where((c) => !existingIds.contains(c.id))
            .toList();

        comments.insertAll(0, newOnes);
        total = result.comments.total;
        update();
      }
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  DataPostComments? findComment(int id) {
    for (final c in comments) {
      if (c.id == id) return c;
    }

    for (final list in repliesMap.values) {
      for (final c in list) {
        if (c.id == id) return c;
      }
    }

    return null;
  }

  Future<void> _prependLatestReply({
    required int targetUserId,
    required int postId,
    required int parentId,
  }) async {
    try {
      final result = await _commentsServices.getCommentReplies(
        targetUserId: targetUserId,
        postId: postId,
        commentId: parentId,
        page: 1,
      );

      if (result.success) {
        final existing = repliesMap[parentId] ?? [];
        final existingIds = existing.map((c) => c.id).toSet();
        final newOnes = result.replies.data
            .where((c) => !existingIds.contains(c.id))
            .toList();

        repliesMap[parentId] = [...newOnes, ...existing];
        repliesCurrentPage[parentId] = 1;
        repliesLastPage[parentId] = result.replies.lastPage;
        repliesTotal[parentId] = result.replies.total;

        final parentIndex = comments.indexWhere((c) => c.id == parentId);
        if (parentIndex != -1) {
          final parent = comments[parentIndex];
          comments[parentIndex] = parent.copyWith(
            repliesCount: result.replies.total,
            repliesExists: true,
          );
        }

        expandedReplies.add(parentId);
        update();
      }
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  Future<void> deleteComment({
    required int targetUserId,
    required int postId,
    required int commentId,
    bool removeMyComment = false,
  }) async {
    try {
      final result = await _commentsServices.deleteComment(
        targetUserId: targetUserId,
        postId: postId,
        commentId: commentId,
      );
      if (result.success) {
        if (removeMyComment) {
          removeCommentById(commentId);
        }
      } else {
        Get.snackbar("Error", result.message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void removeCommentById(int commentId) {
    final beforeTop = comments.length;
    comments.removeWhere((comment) => comment.id == commentId);

    if (comments.length != beforeTop) {
      if (total > 0) total -= 1;
      update();
      return;
    }

    for (final entry in repliesMap.entries) {
      final beforeReplies = entry.value.length;
      entry.value.removeWhere((c) => c.id == commentId);

      if (entry.value.length != beforeReplies) {
        final parentIndex = comments.indexWhere((c) => c.id == entry.key);
        if (parentIndex != -1) {
          final parent = comments[parentIndex];
          final newCount = (parent.repliesCount - 1).clamp(0, 1 << 30);
          comments[parentIndex] = parent.copyWith(
            repliesCount: newCount,
            repliesExists: newCount > 0,
          );
        }
        if (total > 0) total -= 1;
        break;
      }
    }

    update();
  }

  bool isProcessing = false;

  Future<bool> _manage({
    required int postId,
    required int commentId,
    required String action,
  }) async {
    try {
      isProcessing = true;
      update();

      final response = await _commentsServices.manageComments(
        postId: postId,
        commentId: commentId,
        action: action,
      );

      return response.success;
    } catch (e) {
      return false;
    } finally {
      isProcessing = false;
      update();
    }
  }

  Future<bool> pinComment({required int postId, required int commentId}) {
    return _manage(postId: postId, commentId: commentId, action: 'pin');
  }

  Future<bool> unpinComment({required int postId, required int commentId}) {
    return _manage(postId: postId, commentId: commentId, action: 'unpin');
  }

  Future<bool> markAsBest({required int postId, required int commentId}) {
    return _manage(postId: postId, commentId: commentId, action: 'best');
  }

  Future<bool> unmarkAsBest({required int postId, required int commentId}) {
    return _manage(postId: postId, commentId: commentId, action: 'unbest');
  }

  // Future<bool> deleteYourComment({
  //   required int targetUserId,
  //   required int postId,
  //   required int commentId,
  // }) async {
  //   try {
  //     isProcessing = true;
  //     update();

  //     final response = await _commentsServices.deleteComment(
  //       targetUserId: targetUserId,
  //       postId: postId,
  //       commentId: commentId,
  //     );

  //     return response.success;
  //   } catch (e) {
  //     return false;
  //   } finally {
  //     isProcessing = false;
  //     update();
  //   }
  // }
}
