import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/posts/my_posts_controller.dart';
import 'package:programmers_network_app/data/models/Home/posts/get_archived_posts_model.dart';
import 'package:programmers_network_app/data/services/Home/posts/archive_post_services.dart';

class ArchivePostController extends GetxController {
  final ArchivePostServices _archivePostServices = ArchivePostServices();

  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString errorMessage = ''.obs;

  final RxList<DataArchivedPost> archive = <DataArchivedPost>[].obs;

  int currentPage = 1;
  int lastPage = 1;

  bool get hasMore => currentPage < lastPage;

  @override
  void onInit() {
    super.onInit();
    getArchive();
  }

  Future<void> archivePost(int postNumber) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await _archivePostServices.archivePost(
        postNumber: postNumber,
      );

      if (result.success) {
        Get.snackbar("Success", result.message);

        if (Get.isRegistered<MyPostsController>()) {
          Get.find<MyPostsController>().removePostById(postNumber);
        }
        getArchive();
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

  Future<void> getArchive() async {
    isLoading.value = true;
    errorMessage.value = '';
    currentPage = 1;

    try {
      final result = await _archivePostServices.getArchivedPost(page: 1);

      if (result.success) {
        archive.assignAll(result.data.posts);
        currentPage = result.data.currentPage;
        lastPage = result.data.lastPage;
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

  Future<void> loadMore() async {
    if (isLoadingMore.value || currentPage >= lastPage) return;

    isLoadingMore.value = true;

    try {
      final result = await _archivePostServices.getArchivedPost(
        page: currentPage + 1,
      );

      if (result.success) {
        archive.addAll(result.data.posts);
        currentPage = result.data.currentPage;
        lastPage = result.data.lastPage;
      } else {
        Get.snackbar("Error", result.message);
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> restorePost(int postNumber) async {
    errorMessage.value = '';
    try {
      final result = await _archivePostServices.restore(postNumber: postNumber);

      if (result.success) {
        Get.snackbar("Success", result.message);
        archive.removeWhere((post) => post.id == postNumber);

        if (Get.isRegistered<MyPostsController>()) {
          Get.find<MyPostsController>().fetchPosts();
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

  Future<void> forceDeletePost(
    int postNumber, {
    bool removeFromMyPosts = false,
    bool removeFromArchive = false,
  }) async {
    try {
      final result = await _archivePostServices.forceDelete(
        postNumber: postNumber,
      );

      if (result.success) {
        Get.snackbar("Success", result.message);

        if (removeFromArchive) {
          archive.removeWhere((post) => post.id == postNumber);
        }

        if (removeFromMyPosts && Get.isRegistered<MyPostsController>()) {
          Get.find<MyPostsController>().removePostById(postNumber);
        }
      } else {
        Get.snackbar("Error", result.message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
