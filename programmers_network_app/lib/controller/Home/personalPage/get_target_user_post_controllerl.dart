import 'package:get/get.dart';
import 'package:programmers_network_app/data/models/Home/search_post_model.dart';
import 'package:programmers_network_app/data/services/Home/personalPage/get_target_user_post_services.dart';

class TargetUserPostsController extends GetxController {
  final GetTargetUserPostServices _postServices = GetTargetUserPostServices();

  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString errorMessage = ''.obs;

  final RxList<Post> posts = <Post>[].obs;

  int currentPage = 1;
  int lastPage = 1;

  bool get hasMore => currentPage < lastPage;

  Future<void> fetchPosts({required int targetUserId}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _postServices.getTargetUserPost(
        targetUserId: targetUserId,
        page: 1,
      );

      posts.assignAll(result.data.posts.data);
      currentPage = result.data.posts.currentPage;
      lastPage = result.data.posts.lastPage;
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst("Exception: ", "");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore({required int targetUserId}) async {
    if (!hasMore || isLoadingMore.value) return;

    try {
      isLoadingMore.value = true;

      final result = await _postServices.getTargetUserPost(
        targetUserId: targetUserId,
        page: currentPage + 1,
      );

      posts.addAll(result.data.posts.data);
      currentPage = result.data.posts.currentPage;
      lastPage = result.data.posts.lastPage;
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst("Exception: ", "");
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshPosts({required int targetUserId}) async {
    posts.clear();
    currentPage = 1;
    lastPage = 1;
    await fetchPosts(targetUserId: targetUserId);
  }

  void updateReaction({required int postId, required String reaction}) {
    final index = posts.indexWhere((p) => p.id == postId);
    if (index == -1) return;

    final post = posts[index];
    final wasLiked = post.reactionStatus == 'like';
    final wasDisliked = post.reactionStatus == 'dislike';
    final isLikeTap = reaction == 'like';

    int newLikes = post.likesCount;
    int newDislikes = post.disLikesCount;
    String? newStatus;

    if (isLikeTap) {
      if (wasLiked) {
        newLikes--;
        newStatus = '';
      } else {
        newLikes++;
        if (wasDisliked) newDislikes--;
        newStatus = 'like';
      }
    } else {
      if (wasDisliked) {
        newDislikes--;
        newStatus = '';
      } else {
        newDislikes++;
        if (wasLiked) newLikes--;
        newStatus = 'dislike';
      }
    }

    posts[index] = post.copyWith(
      likesCount: newLikes,
      disLikesCount: newDislikes,
      reactionStatus: newStatus,
    );
  }

  void updateSavedPost(int postId) {
    final index = posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      posts[index] = posts[index].copyWith(isSaved: !posts[index].isSaved);
      posts.refresh();
    }
  }
}
