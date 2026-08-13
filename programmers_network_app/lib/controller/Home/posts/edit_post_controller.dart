import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/personalPage/get_target_user_post_controllerl.dart';
import 'package:programmers_network_app/controller/Home/posts/my_posts_controller.dart';
import 'package:programmers_network_app/controller/Home/search_controller.dart';
import 'package:programmers_network_app/data/models/Home/posts/get_my_posts_model.dart';
import 'package:programmers_network_app/data/models/Home/posts/get_post_views_model.dart';
import 'package:programmers_network_app/data/services/Home/posts/edit_post_services.dart';

class EditPostController extends GetxController {
  final EditPostServices _editPostServices = EditPostServices();

  bool isLoading = false;
  final RxString errorMessage = ''.obs;

  final RxList<PostMediaModel> postMedia = <PostMediaModel>[].obs;

  List<ViewUser> viewUser = [];
  bool isLoadingMore = false;
  int currentPage = 1;
  int lastPage = 1;
  int total = 0;
  int? currentTarget;
  int? currentPostId;

  Future<void> pinnedPost(int postNumber) async {
    isLoading = true;
    errorMessage.value = '';

    try {
      final result = await _editPostServices.pinnedPost(postNumber: postNumber);

      if (result.success) {
        if (Get.isRegistered<MyPostsController>()) {
          Get.find<MyPostsController>().updatePinnedPost(postNumber);
        }
      } else {
        Get.snackbar("Error", result.message);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Error", errorMessage.value);
    } finally {
      isLoading = false;
    }
  }

  Future<void> deletemedia(int postId, int postMediaId) async {
    try {
      final result = await _editPostServices.deleteMedia(
        postId: postId,
        postMediaId: postMediaId,
      );

      if (result.success) {
        postMedia.removeWhere((media) => media.id == postMediaId);

        if (Get.isRegistered<MyPostsController>()) {
          Get.find<MyPostsController>().removeMediaFromPost(
            postId,
            postMediaId,
          );
        }

        Get.snackbar("Success", result.message);
      } else {
        Get.snackbar("Error", result.message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // Future<void> savePost({
  //   required int targetUserId,
  //   required int postId,
  // }) async {
  //   isLoading = true;
  //   errorMessage.value = '';

  //   try {
  //     final result = await _editPostServices.savePost(
  //       targetUserId: targetUserId,
  //       postId: postId,
  //     );

  //     if (result.success) {
  //       if (Get.isRegistered<SearchPageController>()) {
  //         Get.find<SearchPageController>().updateSavedPost(postId);
  //       }
  //       Get.snackbar("Success", result.message);
  //     } else {
  //       Get.snackbar("Error", result.message);
  //     }
  //   } catch (e) {
  //     errorMessage.value = e.toString();
  //     Get.snackbar("Error", errorMessage.value);
  //   } finally {
  //     isLoading = false;
  //   }
  // }

  Future<void> savePost({
    required int targetUserId,
    required int postId,
  }) async {
    isLoading = true;
    errorMessage.value = '';

    try {
      final result = await _editPostServices.savePost(
        targetUserId: targetUserId,
        postId: postId,
      );

      if (result.success) {
        if (Get.isRegistered<SearchPageController>()) {
          Get.find<SearchPageController>().updateSavedPost(postId);
        }

        final tag = 'posts_$targetUserId';
        if (Get.isRegistered<TargetUserPostsController>(tag: tag)) {
          Get.find<TargetUserPostsController>(tag: tag).updateSavedPost(postId);
        }

        Get.snackbar("Success", result.message);
      } else {
        Get.snackbar("Error", result.message);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Error", errorMessage.value);
    } finally {
      isLoading = false;
    }
  }

  final Set<int> _sentUserId = {};

  Future<void> registerView({
    required int targetUserId,
    required int postId,
    required String source,
  }) async {
    if (_sentUserId.contains(postId)) {
      return;
    }

    _sentUserId.add(postId);
    try {
      final result = await _editPostServices.saveRecoredPost(
        targetUserId: targetUserId,
        postId: postId,
        source: source,
      );

      if (result.success) {
        if (Get.isRegistered<SearchPageController>()) {
          Get.find<SearchPageController>().incrementLocalViewCount(postId);
        }
      } else {
        _sentUserId.remove(postId);
      }
    } catch (e) {
      _sentUserId.remove(postId);
    }
  }

  Future<void> getViewPost({
    required int targetUserId,
    required int postId,
    bool refresh = true,
  }) async {
    if (isLoading) return;
    if (refresh) {
      currentPage = 1;
      viewUser.clear();
    }

    currentTarget = targetUserId;
    currentPostId = postId;

    isLoading = true;
    errorMessage.value = '';
    update();

    try {
      final result = await _editPostServices.getPostView(
        targetUserId: targetUserId,
        postId: postId,
        page: currentPage,
      );
      if (result.success) {
        viewUser.addAll(result.data.users);
        lastPage = result.data.lastPage;
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
    if (currentTarget == null || currentPostId == null) {
      return;
    }

    isLoadingMore = true;
    update();
    currentPage++;

    try {
      final result = await _editPostServices.getPostView(
        targetUserId: currentTarget!,
        postId: currentPostId!,
        page: currentPage,
      );

      if (result.success) {
        viewUser.addAll(result.data.users);
        lastPage = result.data.lastPage;
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
