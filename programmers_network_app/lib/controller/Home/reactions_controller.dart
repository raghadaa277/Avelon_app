import 'package:get/get.dart';
import 'package:programmers_network_app/data/models/Home/get_reactions_post_model.dart';
import 'package:programmers_network_app/data/services/Home/reactions_services.dart';

class ReactionsController extends GetxController {
  final ReactionsServices _reactions = ReactionsServices();

  List<ReactionUser> reaction = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  int currentPage = 1;
  int lastPage = 1;
  int total = 0;
  int likesCount = 0;
  int dislikesCount = 0;
  int? currentReactionTarget;
  int? currentPostId;
  String? currentType;

  final RxString errorMessage = ''.obs;

  Future<bool> reactions({
    required int targetUserId,
    required int postId,
    required String type,
  }) async {
    update();
    try {
      final result = await _reactions.reactions(
        targetUserId: targetUserId,
        postId: postId,
        type: type,
      );
      return result.success;
    } catch (e) {
      return false;
    } finally {
      update();
    }
  }

  Future<void> getReactions({
    required int targetUserId,
    required int postId,
    required String type,
    bool refresh = true,
  }) async {
    if (isLoading) return;

    if (refresh) {
      currentPage = 1;
      reaction.clear();
    }

    currentReactionTarget = targetUserId;
    currentPostId = postId;
    currentType = type;

    isLoading = true;
    errorMessage.value = '';
    update();

    try {
      final result = await _reactions.getReations(
        targetUserId: targetUserId,
        postId: postId,
        type: type,
        page: currentPage,
      );
      if (result.success) {
        reaction.addAll(result.data.reactions);
        lastPage = result.data.lastPage;
        total = result.data.total;

        if (type == 'like') {
          likesCount = total;
        } else if (type == 'dislike') {
          dislikesCount = total;
        }
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
    if (currentReactionTarget == null ||
        currentPostId == null ||
        currentType == null) {
      return;
    }

    isLoadingMore = true;
    update();
    currentPage++;

    try {
      final result = await _reactions.getReations(
        targetUserId: currentReactionTarget!,
        postId: currentPostId!,
        type: currentType!,
        page: currentPage,
      );

      if (result.success) {
        reaction.addAll(result.data.reactions);
        lastPage = result.data.lastPage;
        total = result.data.total;

        if (currentType == 'like') {
          likesCount = total;
        } else if (currentType == 'dislike') {
          dislikesCount = total;
        }
      }
    } catch (e) {
      currentPage--;
      errorMessage.value = e.toString();
    } finally {
      isLoadingMore = false;
      update();
    }
  }
}
