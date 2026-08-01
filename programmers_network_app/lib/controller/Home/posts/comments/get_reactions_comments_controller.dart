import 'package:get/get.dart';
import 'package:programmers_network_app/data/models/Home/posts/comments/get_reactions_comment_model.dart';
import 'package:programmers_network_app/data/services/Home/posts/comments/comments_services.dart';

class GetReactionsCommentController extends GetxController {
  final CommentsServices _commentsServices = CommentsServices();

  bool isLoading = false;
  bool isLoadingMore = false;

  final RxString errorMessage = ''.obs;

  List<GetReactionCommentUser> reactions = [];

  int currentPage = 1;
  int lastPage = 1;
  int total = 0;

  int? currentTargetUserId;
  int? currentPostId;
  int? currentCommentId;
  String? currentType;

  Future<void> getReactions({
    required int targetUserId,
    required int postId,
    required int commentId,
    required String type,
    bool refresh = true,
  }) async {
    if (isLoading) return;

    if (!refresh &&
        reactions.isNotEmpty &&
        currentCommentId == commentId &&
        currentType == type) {
      return;
    }

    if (refresh) {
      currentPage = 1;
      reactions.clear();
    }

    currentTargetUserId = targetUserId;
    currentPostId = postId;
    currentCommentId = commentId;
    currentType = type;

    isLoading = true;
    errorMessage.value = '';

    update();

    try {
      final result = await _commentsServices.getReations(
        targetUserId: targetUserId,
        postId: postId,
        commentId: commentId,
        type: type,
        page: currentPage,
      );

      if (result.success) {
        reactions = result.data.reactions;

        lastPage = result.data.lastPage;

        total = result.data.total;
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

    if (currentTargetUserId == null ||
        currentPostId == null ||
        currentCommentId == null ||
        currentType == null) {
      return;
    }

    isLoadingMore = true;

    update();

    final nextPage = currentPage + 1;

    try {
      final result = await _commentsServices.getReations(
        targetUserId: currentTargetUserId!,
        postId: currentPostId!,
        commentId: currentCommentId!,
        type: currentType!,
        page: nextPage,
      );

      if (result.success) {
        final ids = reactions.map((e) => e.id).toSet();

        final newUsers = result.data.reactions
            .where((e) => !ids.contains(e.id))
            .toList();

        reactions.addAll(newUsers);

        currentPage = nextPage;

        lastPage = result.data.lastPage;

        total = result.data.total;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadingMore = false;

      update();
    }
  }

  void clear() {
    reactions.clear();

    currentPage = 1;
    lastPage = 1;
    total = 0;

    errorMessage.value = '';

    update();
  }
}
