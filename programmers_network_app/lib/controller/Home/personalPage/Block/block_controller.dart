import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/posts/get_save_post_controller.dart';
import 'package:programmers_network_app/controller/Home/search_controller.dart';
import 'package:programmers_network_app/data/services/Home/personalPage/block/toogle_bloc_services.dart';

class BlockController extends GetxController {
  final ToogleBlocServices _blockServices = ToogleBlocServices();

  bool isLoading = false;
  final RxString errorMessage = ''.obs;

  final RxSet<int> blockedUserIds = <int>{}.obs;

  bool isBlocked(int userId) => blockedUserIds.contains(userId);

  Future<bool> toggleBlock({
    required int targetUserId,
    required bool currentlyBlocked,
  }) async {
    isLoading = true;
    errorMessage.value = '';
    update();

    try {
      final result = await _blockServices.toggleBlock(
        targetUserId: targetUserId,
      );

      if (result.success) {
        if (currentlyBlocked) {
          blockedUserIds.remove(targetUserId);
        } else {
          blockedUserIds.add(targetUserId);
          _purgeUserContentEverywhere(targetUserId);
        }

        Get.snackbar("Success", result.message);
        return true;
      } else {
        errorMessage.value = result.message;

        return false;
      }
    } catch (e) {
      errorMessage.value = e.toString();

      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  void _purgeUserContentEverywhere(int userId) {
    if (Get.isRegistered<SavedPostsController>()) {
      Get.find<SavedPostsController>().removePostsByUser(userId);
    }
    if (Get.isRegistered<SearchPageController>()) {
      Get.find<SearchPageController>().removePostsByUser(userId);
    }
  }
}
