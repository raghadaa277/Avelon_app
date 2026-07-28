import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/posts/my_posts_controller.dart';
import 'package:programmers_network_app/controller/Home/search_controller.dart';
import 'package:programmers_network_app/data/models/Home/posts/get_my_posts_model.dart';
import 'package:programmers_network_app/data/services/Home/posts/edit_post_services.dart';

class EditPostController extends GetxController {
  final EditPostServices _editPostServices = EditPostServices();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final RxList<PostMediaModel> postMedia = <PostMediaModel>[].obs;

  Future<void> pinnedPost(int postNumber) async {
    isLoading.value = true;
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
      isLoading.value = false;
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

  Future<void> savePost({
    required int targetUserId,
    required int postId,
  }) async {
    isLoading.value = true;
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
        Get.snackbar("Success", result.message);
      } else {
        Get.snackbar("Error", result.message);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Error", errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}
