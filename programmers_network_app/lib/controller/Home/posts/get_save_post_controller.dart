import 'package:get/get.dart';
import 'package:programmers_network_app/data/models/Home/posts/get_save_post_model.dart';
import 'package:programmers_network_app/data/models/Home/search_post_model.dart';
import 'package:programmers_network_app/data/services/Home/posts/edit_post_services.dart';

class SavedPostsController extends GetxController {
  final EditPostServices _savedPostsServices = EditPostServices();

  bool isLoading = false;
  bool isLoadingMore = false;

  final RxString errorMessage = ''.obs;

  final RxList<Post> savedPosts = <Post>[].obs;

  int currentPage = 1;
  int lastPage = 1;
  int total = 0;

  Future<void> getSavedPosts({bool refresh = true}) async {
    if (isLoading) return;

    if (refresh) {
      currentPage = 1;
      savedPosts.clear();
    }

    isLoading = true;
    errorMessage.value = '';

    update();

    try {
      final result = await _savedPostsServices.getSavePost(page: currentPage);

      if (result.success) {
        currentPage = result.data.currentPage;
        lastPage = result.data.lastPage;
        total = result.data.total;

        savedPosts.assignAll(result.data.posts);
      } else {
        errorMessage.value = result.message;
      }
    } catch (e, stackTrace) {
      print(stackTrace);

      errorMessage.value = e.toString();
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore || isLoading) return;

    if (currentPage >= lastPage) {
      return;
    }

    final nextPage = currentPage + 1;

    isLoadingMore = true;
    update();

    try {
      final result = await _savedPostsServices.getSavePost(page: nextPage);

      if (result.success) {
        currentPage = result.data.currentPage;
        lastPage = result.data.lastPage;

        savedPosts.addAll(result.data.posts);
      } else {
        errorMessage.value = result.message;
      }
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
      isLoadingMore = false;
      update();
    }
  }

  void removeSavedPost(int postId) {
    savedPosts.removeWhere((post) => post.id == postId);

    if (total > 0) {
      total--;
    }

    update();
  }

  Future<void> refreshPosts() async {
    await getSavedPosts(refresh: true);
  }

  void removePostsByUser(int userId) {
    final removedCount = savedPosts
        .where((post) => post.user.id == userId)
        .length;
    savedPosts.removeWhere((post) => post.user.id == userId);

    total = (total - removedCount).clamp(0, total);
    update();
  }
}
